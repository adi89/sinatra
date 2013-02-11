require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'


get '/' do
    sql= 'SELECT * FROM todos;'
    conn= PG.connect(:dbname => 'todo', :host => 'localhost')
    @rows= conn.exec(sql)
    conn.close
    erb :home
end

get '/new' do
  erb :new
  end

get '/faq' do
  erb :faq
end

post '/create' do

  task= params[:task]
  description= params[:description]

  sql= "INSERT INTO todos (task, description) VALUES ('#{task}' , '#{description}');"
  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  conn.exec(sql)
  conn.close

  redirect to ("/")
end

