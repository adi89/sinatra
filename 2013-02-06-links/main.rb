require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/'  do
  erb :home
end

get '/sports' do
  erb :sports
end

get '/weather' do
  erb :weather
end

get '/gossip' do
  erb :gossip
end

get '/celebrity' do
  erb :celebrity
end

post '/navigate' do
  case params[:destination].downcase
  when 'sports' then redirect to('/sports')
  when 'weather' then redirect to('/weather')
  when 'gossip' then redirect to('/gossip')
  when 'celebrity' then redirect to('/celebrity')
  else redirect to ("/")
  end
#navigate gets hit as soon as you press button then directs to params
end
#so for one of these value. give the params to browser, it gives back a redirect render.
