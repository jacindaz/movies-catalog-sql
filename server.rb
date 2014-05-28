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
  actors_query = "SELECT name,id FROM actors ORDER BY name ASC LIMIT 10"

  @actors = db_connection do |conn|
              conn.exec(actors_query)
            end

  erb :'actors/index'
end

get '/actors/:id' do
  @id = params[:id]

  actor_query = "SELECT actors.id,actors.name,
                    movies.title AS movie, movies.id AS movie_id,
                    cast_members.character AS role
                 FROM actors
                    JOIN cast_members ON actors.id = cast_members.actor_id
                    JOIN movies ON cast_members.movie_id = movies.id
                  WHERE actors.id = $1"

  @actor_info = db_connection do |conn|
              conn.exec_params(actor_query,[@id])
            end

  @title = "#{@actor_info[0]["name"]}"

  erb :'actors/show'
end



get '/movies' do
  @title = "Movies page"
  movies_query = "SELECT movies.id,movies.title,movies.year,movies.rating,genres.name AS genre,studios.name AS studio
                  FROM movies
                    JOIN studios ON movies.studio_id = studios.id
                    JOIN genres ON movies.genre_id = genres.id
                  ORDER BY movies.title ASC"

  @movies = db_connection do |conn|
              conn.exec(movies_query)
            end

  erb :'movies/index'
end


get '/movies/:id' do
  @movie_id = params[:id]
  movie_query = "SELECT movies.id,movies.title AS movie,movies.year,movies.rating,
                        genres.name AS genre,
                        studios.name AS studio,
                        cast_members.character AS role,
                        actors.name AS actor
                  FROM movies
                    JOIN studios ON movies.studio_id = studios.id
                    JOIN genres ON movies.genre_id = genres.id
                    JOIN cast_members ON movies.id = cast_members.movie_id
                    JOIN actors ON actors.id = cast_members.actor_id
                  WHERE movies.id = $1"

  @movies_info = db_connection do |conn|
                    conn.exec_params(movie_query, [@movie_id])
                  end


  @title = "Movie"
  erb :'movies/show'
end
