require 'twitter'
require 'sinatra'
require 'aws-sdk-core'

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

dynamo_db = Aws::DynamoDB::Client.new(
  :region => ENV["DYNAMODB_REGION"],
  :access_key_id => ENV["DYNAMODB_ACCESS_KEY"],
  :secret_access_key => ENV["DYNAMODB_SECRET_ACCESS_KEY"]
)

get '/' do
	options = {"count" => 1000}
	@timeline = twClient.user_timeline("MacFriends_", options)
	erb :test
end

get '/about' do
	erb :about
end

get '/db' do
  @dynamodb = dynamo_db.get_item(
    table_name: "tweets",
    key: {
      "tweet_id" => 527300424303259649
    },
    consistent_read: true
  ).item
  erb :db
end
