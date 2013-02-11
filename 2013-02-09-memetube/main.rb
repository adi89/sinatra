require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

before do #creates menus before anything else happens.
sql= "SELECT DISTINCT genre from memes;"
@nav_rows= run_sql(sql) #each hash is key val pair of genre
end


get '/' do
  erb :home
end

get '/new' do
  erb :new #redirects you to the new page
end

get '/vids' do
  sql = "SELECT * from memes;"
  @rows= run_sql(sql) #will return an array
  erb :vids
end

get '/vids/:genre' do #this :genre is arbitrary. all that matters is that you place a value into a key, which is used as a key for the params
  sql = "select * from memes where genre = '#{params['genre']}';"
  @rows= run_sql(sql) #will return array w/ hashes
  erb :vids
end

get "/vids/:vid_id/edit" do
sql= "SELECT * FROM memes where id= '#{params["vid_id"]}';"
rows= run_sql(sql)
@row= rows.first #there's only going to be one element in the array anyway since you're editing a specific thing and retrieving it from the database. .first retrieves that item, which is of course a hash.
erb :new
end


#check here
post "/vids/:vid_id" do
sql = "UPDATE memes SET title = '#{params[:title]}', description = '#{params[:description]}', genre = '#{params[:genre]}', url = '#{params[:url]}' WHERE id = '#{params['vid_id']}'"
  run_sql(sql)
  redirect to ('/vids')
end

post "/vids/:vid_id/delete" do #you put the vid_id which will then be a parameter going in the sql, which will delete the video
sql= "delete from memes where id= '#{params['vid_id']}';"
run_sql(sql) #thus user input dictates which id is deleted. but we know that user input that's in vids, will be selected via a button. that button is on the vids page in the form page w/ the action corresponding to vids/<%= row['id'] %>
  redirect to ('/vids')
end



post '/create' do
  sql= "INSERT INTO memes (title, genre, description, url) VALUES ('#{params['title']}', '#{params['genre']}', '#{params['description']}', '#{params[
    'url']}')"
  run_sql(sql)
  redirect to '/vids' #here , display the title, description, genre, and url
end






def run_sql(sql)
  conn = PG.connect(:dbname =>'memetube', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end