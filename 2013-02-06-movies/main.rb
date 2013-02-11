require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'httparty'
require 'active_support/all'
require 'json'




#as of now we have a have a hash w/ parameters about the movie



get '/' do
  erb :home
end

get '/faq' do
  erb :faq
end

get '/about' do
  erb :about
end

get '/movies' do
  sql= 'select poster from movies'

  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
          @rows= conn.exec(sql)
          conn.close
          erb :posters
    end


get '/navigate' do

      ft = params[:destination].split.join("+")
      composite = "http://www.omdbapi.com/?i=&t="
      mov_name = composite + ft
      input = HTTParty.get(mov_name)

        @names = JSON(input.body)



        sql = "insert into movies (title, year, released, director, writers, actors, poster) values ('#{@names['itTitle']}', '#{@names['Year']}', '#{@names['Released']}', '#{@names['Director']}', '#{@names['Writers']}', '#{@names['Actors']}', '#{@names['Poster']}')"

          conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
          conn.exec(sql)
          conn.close




  erb :home
  end

# target='_blank' opens up a new tab.
#href for movie website.cd




