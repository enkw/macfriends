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
  :database => ENV["MYSQL_DATABASE"]
  )

get '/' do
	options = {"count" => 1000}
	@timeline = twClient.user_timeline("MacFriends_", options)
	erb :test
end

get '/about' do
	erb :about
end

get '/mysql' do
  @mysql = client.query("SELECT * from tweets ORDER BY rt_cnt DESC")
  erb :mysql
end

get '/category' do
  @mysql = client.query("SELECT * from tweets where hashtags != 'NULL' ORDER BY created_at DESC", :as => :hash)
  @tags = client.query("SELECT * from tags")
  erb :category
end

get '/test2/:tag' do
  content_type :json
  query = "select * from tweets where hashtags like '%#" + params[:tag] + "#%'"
  result = client.query(query, :as => :json)
  data = []
  result.each do |ms|
    data.push(ms)
  end
  data.to_json
end
