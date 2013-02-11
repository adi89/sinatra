require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
# code inside of contrib library^^.

get '/hello' do
  'I am a master hacker ninja!'
end

#get is like select. when a comp sends a request
#to a server, it is sending both an address and a verb.
#usually the verb is a get. put '/hello' in a path and get is the verb.

get '/' do
  'this is the home page'
end

get '/Adi' do
  'Cheat code~'
end
=begin
get "/name/:first/:last/:age/" do
  "your name is => #{params[:first]} #{params[:last]} and age is #{params[:age]}"

end

#params is a hash. :first is a key.

get "/calc/multiply/:x/:y" do
  @result= params[:x].to_f * params[:y].to_f
erb :calc
end

get '/calc/add/:x/:y' do
  @result= params[:x].to_f + params[:y].to_f
  erb :calc
end
=end

get '/calc' do
  @first = params[:first].to_f
  @second= params[:second].to_f
  @result= case params[:operator]
    when '+' then @first + @second
    when '*' then @first * @second
    when '-' then @first - @second
    when '/' then @first / @second
    end

  erb :calc #rendering
  end

