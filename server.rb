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
  actors_query = "SELECT name FROM actors ORDER BY name ASC LIMIT 10"

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
  movies_query = "SELECT movies.title,movies.year,movies.rating,genres.name AS genre,studios.name AS studio
                  FROM movies
                    JOIN studios ON movies.studio_id = studios.id
                    JOIN genres ON movies.genre_id = genres.id
                  ORDER BY movies.title ASC LIMIT 10"

  @movies = db_connection do |conn|
            conn.exec(movies_query)
          end

  erb :'movies/index'
end


get '/movies/:id' do
  @id = params[:id]
  @title = "Movie #{@id} page"

  erb :'movies/show'
end
