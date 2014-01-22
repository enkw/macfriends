require 'twitter'
require 'sinatra'

TW_CONSUMER_KEY        = "your_consumer_key"
TW_CONSUMER_SECRET     = "your_consumer_secret"
TW_ACCESS_TOKEN        = "your_access_token"
TW_ACCESS_TOKEN_SECRET = "your_access_token_secret"

twClient = Twitter::REST::Client.new do |config|
    config.consumer_key        = TW_CONSUMER_KEY
    config.consumer_secret     = TW_CONSUMER_SECRET
    config.access_token        = TW_ACCESS_TOKEN
    config.access_token_secret = TW_ACCESS_TOKEN_SECRET
end


get '/' do

word = "#macfriends";
puts results = twClient.search(word, :count => 100, :result_type => "recent")

html = ""
   results.attrs[:statuses].each do |tweet|
     #html = tweet[:user].to_s
     #html += "<p>"+tweet[:user].to_s+"</p>"
     html += "<h1>"+"@"+tweet[:user][:screen_name]+"</h1>"
     #html += "<h2>"+tweet[:statuses]+"</h2>"
     #html += "<img src="+tweet[:user][:url].to_s+">"
     #html += "<p>"+tweet[:lang]+"</p>"
     #html += "<br>"
   end
   html
end
