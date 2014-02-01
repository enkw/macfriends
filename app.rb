require 'twitter'
require 'sinatra'

TW_CONSUMER_KEY        = "your_consumer_key"
TW_CONSUMER_SECRET     = "your_consumer_secret"
TW_ACCESS_TOKEN        = "your_access_token"
TW_ACCESS_TOKEN_SECRET = "your_access_token_secret"

#@Client = Twitter::REST::Client
#twClient = @Client.new do |config|
#	config.consumer_key        = TW_CONSUMER_KEY
#    config.consumer_secret     = TW_CONSUMER_SECRET
#    config.access_token        = TW_ACCESS_TOKEN
#    config.access_token_secret = TW_ACCESS_TOKEN_SECRET
#end

twClient = Twitter::REST::Client.new do |config|
    config.consumer_key        = TW_CONSUMER_KEY
    config.consumer_secret     = TW_CONSUMER_SECRET
    config.access_token        = TW_ACCESS_TOKEN
    config.access_token_secret = TW_ACCESS_TOKEN_SECRET
end


get '/' do

	word = "#macfriends";
	puts results = twClient.search(word, :count => 100, :result_type => "recent")
	#html = ""
	results.attrs[:statuses].each do |tweet|
		#html += "<h2>"+"@"+tweet[:user][:screen_name]+"</h2>"
		#html += "<p>"+tweet[:text].to_s+"</p>"
    	#if tweet[:entities][:media] != nil
		#html += "<img src="+tweet[:entities][:media][0][:media_url].to_s+">"
		#end
		#html += "<p>"+tweet.to_s+"</p>"

		@username = tweet[:user][:screen_name].to_s
		@text = tweet[:text].to_s
		if tweet[:entities][:media] != nil
			@media_url = tweet[:entities][:media][0][:media_url].to_s
		end
	end
   	#html
	erb :index
end

get '/about' do
  erb :about
end
