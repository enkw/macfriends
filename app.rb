require 'twitter'
require 'sinatra'
require 'mysql2'
require 'json'

TW_CONSUMER_KEY        = ENV["TWCK"]
TW_CONSUMER_SECRET     = ENV["TWCS"]
TW_ACCESS_TOKEN        = ENV["TWAT"]
TW_ACCESS_TOKEN_SECRET = ENV["TWATS"]

twClient = Twitter::REST::Client.new do |config|
    config.consumer_key        = TW_CONSUMER_KEY
    config.consumer_secret     = TW_CONSUMER_SECRET
    config.access_token        = TW_ACCESS_TOKEN
    config.access_token_secret = TW_ACCESS_TOKEN_SECRET
end

client = Mysql2::Client.new(
  :host => ENV["MYSQL_HOST"],
  :username => ENV["MYSQL_USERNAME"],
  :password => ENV["MYSQL_PASS"],
  :database => ENV["MYSQL_DATABASE"],
  :reconnect => true,
  :port => 3306
  )

helpers do
  def protect!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end
  def authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    username = ENV["BASIC_AUTH_USERNAME"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [username, password]
  end
end

get '/' do
	options = {"count" => 1000}
	@timeline = twClient.user_timeline("MacFriends_", options)
	erb :index
end

get '/about' do
	erb :about
end

get '/rank' do
  @mysql = client.query("SELECT * from tweets ORDER BY rt_cnt DESC")
  erb :rank
end

get '/category' do
  @mysql = client.query("SELECT * from tweets where hashtags != 'NULL' ORDER BY created_at DESC", :as => :hash)
  @tags = client.query("SELECT * from tags")
  erb :category
end

get '/hashtags/:tag' do
  content_type :json
  query = "select * from tweets where hashtags like '%#" + params[:tag] + "#%'"
  result = client.query(query, :as => :json)
  data = []
  result.each do |ms|
    data.push(ms)
  end
  data.to_json
end

get '/admin' do
  protect!
  erb :admin
end

not_found do
  erb :error
end
