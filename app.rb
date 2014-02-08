require 'twitter'
require 'sinatra'

<<<<<<< HEAD
TW_CONSUMER_KEY        = "bJAb7SxAbRLiUSz71OMsg"
TW_CONSUMER_SECRET     = "DEj6kayV1V7AD8jXRAvs3BfNg52ofCjovCr2K9o4"
TW_ACCESS_TOKEN        = "381595197-jWrB4H27IXe334gQEUAmiYySQXmEfsqRdVagojUe"
TW_ACCESS_TOKEN_SECRET = "7xY47I7fsnDUYsXKUMEBJXQ3ThG4aQ1K4RBP5NZzw2g0E"
=======
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
>>>>>>> 8daaa01e05ffc7e5cfba3afe082b0c3d542c5f69

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
