require 'twitter'
require 'sinatra'

TW_CONSUMER_KEY        = "your_twitter_consumer_key"
TW_CONSUMER_SECRET     = "your_twitter_consumer_secret"
TW_ACCESS_TOKEN        = "your_twitter_access_token"
TW_ACCESS_TOKEN_SECRET = "your_twitter_access_token_secret"

twClient = Twitter::REST::Client.new do |config|
    config.consumer_key        = TW_CONSUMER_KEY
    config.consumer_secret     = TW_CONSUMER_SECRET
    config.access_token        = TW_ACCESS_TOKEN
    config.access_token_secret = TW_ACCESS_TOKEN_SECRET
end

get '/' do
	word = "#macfriends";
	@results = twClient.search(word, :count => 100)
	erb :index
end

get '/about' do
	erb :about
end
