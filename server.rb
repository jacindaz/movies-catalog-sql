require 'sinatra'
require 'rubygems'
require 'pry'
require 'pg'


#METHODS--------------------------------------------------------------------------------
def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)

  ensure
    connection.close
  end
end



#ROUTES and VIEWS--------------------------------------------------------------------------------
get '/' do
  @title = "Welcome to the awesomest movies catalog ever"
  erb :'index'
end


get '/actors' do
  @title = "Actors page"
  actors_query = "SELECT name FROM actors ORDER BY name ASC"

  @actors = db_connection do |conn|
              conn.exec(actors_query)
            end

  erb :'actors/index'
end

get '/actors/:id' do
  @id = params[:id]
  @title = "Actor #{@id} page"

  erb :'actors/show'
end



get '/movies' do
  @title = "Movies page"
  erb :'movies/index'
end


get '/movies/:id' do
  @id = params[:id]
  @title = "Movie #{@id} page"

  erb :'movies/show'
end
