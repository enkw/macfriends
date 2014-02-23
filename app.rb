require 'twitter'
require 'sinatra'

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

get '/' do
	options = {"count" => 1000}
	@timeline = twClient.user_timeline("MacFriends_", options)
	erb :test
end

get '/about' do
	erb :about
end

get '/test' do
	word = "#macfriends";
    @results = twClient.search(word, :count => 100)
    erb :index
end
