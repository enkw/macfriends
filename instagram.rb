require "sinatra"
require "instagram"

enable :sessions

CALLBACK_URL = "http://localhost:9393/oauth/callback"

Instagram.configure do |config|
  config.client_id = "6e807f46722c4ba2a1386e07fc7ebbf1"
  config.client_secret = "efaa0a31825d49dd8e9f1e53ee79fe3e"
end

get "/" do
 '<a href="/oauth/connect">Connect with Instagram</a>'
end

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/feed"
end

get "/feed" do
  client = Instagram.client(:access_token => session[:access_token])
  @user = client.user.username
  @recent = client.user_recent_media
end
