require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

#before code gets executed first before any other file (Even layout)
before do
  sql= "select distinct breed from dogs"
  @nav_rows= run_sql(sql)
end

get '/dogs/:jeff' do
  sql = "select * from dogs where breed= '#{params['jeff']}'"
  @rows= run_sql(sql)
  erb :dogs
end

#the colon gets replaced.
post '/dogs/:dog_id/delete' do
  sql = "delete from dogs where id = #{params['dog_id']}"
  run_sql(sql)
  redirect to('/dogs')
end
#so the value of the URL hash, si the key for the params hash in fetching the info from the database.

get '/dogs/:dog_id/edit' do
  sql = "select * from dogs where id = #{params['dog_id']}"
  rows = run_sql(sql)
  @row= rows.first
  #take the first row hash out.
  erb :new
end

get '/'  do
  erb :home
end

get '/new' do
  erb :new
end

post '/dogs/:dog_id' do
  sql = "UPDATE dogs SET name = '#{params[:name]}', photo = '#{params[:photo]}', breed = '#{params[:breed]}' WHERE id = #{params['dog_id']};"
  run_sql(sql)

  redirect to('/dogs')
end


get '/dogs' do
  sql= "select * from dogs"
  @rows = run_sql(sql) #available inside of dogs
  erb :dogs
end


post '/create' do
    name = params[:name]
  photo = params[:photo]
  breed= params[:breed]
  sql = "insert into dogs (name, photo, breed) values ('#{name}', '#{photo}', '#{breed}')"
  run_sql(sql)
  redirect to ('/dogs')
  end


def run_sql(sql)
  conn = PG.connect(:dbname =>'dogdb', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end


