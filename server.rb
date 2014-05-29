require 'sinatra'
require 'rubygems'
require 'pry'
require 'pg'
require 'json'
require 'net/http'


#METHODS--------------------------------------------------------------------------------
def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)

  ensure
    connection.close
  end
end

if !ENV.has_key?("ROTTEN_TOMATOES_API_KEY")
  puts "You need to set the ROTTEN_TOMATOES_API_KEY environment variable."
  #exit 1
end

api_key = ENV["ROTTEN_TOMATOES_API_KEY"]
uri = URI("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{api_key}")

response = Net::HTTP.get(uri)
movie_data = JSON.parse(response)


#ROUTES and VIEWS--------------------------------------------------------------------------------
get '/' do
  @title = "Welcome to the awesomest movies catalog ever"
  erb :'index'
end


get '/actors' do
  @title = "Actors page"
  actors_query = "SELECT name,id FROM actors ORDER BY name ASC LIMIT 20"

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
                        actors.name AS actor, actors.id AS actor_id
                  FROM movies
                    JOIN studios ON movies.studio_id = studios.id
                    JOIN genres ON movies.genre_id = genres.id
                    JOIN cast_members ON movies.id = cast_members.movie_id
                    JOIN actors ON actors.id = cast_members.actor_id
                  WHERE movies.id = $1"

  @movies_info = db_connection do |conn|
                    conn.exec_params(movie_query, [@movie_id])
                  end

  @api_data = movie_data
  @title = "#{@movies_info[0]["movie"]}"
  #@poster_url = @api_data["movies"]["posters"]["original"]

  erb :'movies/show'
end

get '/genres' do
  genre_query = "SELECT genres.id, genres.name AS genre,
                        movies.title, movies.year, movies.rating, movies.id AS movie_id
                FROM genres RIGHT JOIN movies ON movies.genre_id = genres.id
                ORDER BY genres.name,movies.year DESC, movies.rating"
  @genres = db_connection do |conn|
              conn.exec(genre_query)
            end

  @title = "Movies by Genres"
  erb :'genres/index'
end


not_found do
  puts 'Sorry! This page got lost.'
  sleep(5)
  redirect to('/')
end
