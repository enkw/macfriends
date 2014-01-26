require 'twitter'
require 'sinatra'
require 'uri'
require 'net/http'

TW_CONSUMER_KEY        = "bJAb7SxAbRLiUSz71OMsg"
TW_CONSUMER_SECRET     = "DEj6kayV1V7AD8jXRAvs3BfNg52ofCjovCr2K9o4"
TW_ACCESS_TOKEN        = "381595197-K6H2cXUSPAXBiqZd67i206pMFgpe9UevVPD1ty62"
TW_ACCESS_TOKEN_SECRET = "TA9ocbEWpjoIG9Om35zc9or2RVTPysbad0P3NmkAA02ai"

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
     html += "<h1>"+tweet[:user][:name]+"@"+tweet[:user][:screen_name]+"</h1>"
     html += "<h2>"+tweet[:text].to_s+"</h2>"
     html += "<p>"+tweet[:entities][:media][:media_url].to_s+"</p>"
     #html += "<p>"+a[:media_url]+"</p>"
     #html += "<p>"+a.[:media_url].to_s"</p>"
     #html += "<img src="+tweet[:user][:url].to_s+">"
     #html += "<p>"+tweet[:user][:entities][:media][:media_url]+"</p>"
     #html += "<br>"
   end
   html
end

get '/tweet/' do
  @hello = "こんにちは！じぇじぇじぇ！"
  erb :index
end
