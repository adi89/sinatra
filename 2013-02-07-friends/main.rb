require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'


get '/' do
  erb :home
end


get '/newfriends' do
  erb :newfriends
end


get '/friends' do
 sql= 'SELECT * FROM friends;'
     conn= PG.connect(:dbname => 'friends', :host => 'localhost')
    @rows= conn.exec(sql)
    conn.close
   erb :friends
end



post '/newfriend' do

    name= params[:name]
    age= params[:age]
    gender= params[:gender]
    image= params[:image]
    twitter= params[:twitter]
    github= params[:github]
    facebook=params[:facebook]

    sql= "INSERT INTO friends (name, age, gender, image, twitter, github, facebook) VALUES ('#{name}' , '#{age}', '#{gender}', '#{image}', '#{twitter}' , '#{github}', '#{facebook}');"
    run_sql(sql)

    redirect to ('/friends')

  end



def run_sql(sql)
  conn = PG.connect(:dbname =>'friends', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end
