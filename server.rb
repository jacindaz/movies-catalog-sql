require 'sinatra'
require 'rubygems'
require 'pry'
require 'pg'
require 'json'
require 'net/http'
require 'uri'


#METHODS--------------------------------------------------------------------------------
def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)

  ensure
    connection.close
  end
end

def rotten_tomatoes_movie_hash(movie_title)
  if !ENV.has_key?("ROTTEN_TOMATOES_API_KEY")
    puts "You need to set the ROTTEN_TOMATOES_API_KEY environment variable."
    #exit 1
  end

  api_key = ENV["ROTTEN_TOMATOES_API_KEY"]
  movie_title_encode = URI.escape(movie_title)
  uri = URI("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{api_key}&q=#{movie_title_encode}&page_limit=1")
  response = Net::HTTP.get(uri)
  movie_data = JSON.parse(response)
end


#ROUTES and VIEWS--------------------------------------------------------------------------------
get '/' do
  redirect '/movies'
end


get '/actors' do
  @title = "Actors page"
  actors_query = "SELECT name,id FROM actors ORDER BY name ASC"

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
  @search_bar = params["query"]

  if params["query"] == nil
    @search_query = nil
  else
    @search_query = "WHERE movies.title LIKE '%#{@search_bar}%'"
  end

  case params[:order]
  when nil
    @order = "title ASC"
  when "rating"
    @order = params[:order]
    @order = "#{@order} DESC"
  when "year"
    @order = params[:order]
    @order = "#{@order} DESC"
  else
    @order = params[:order]
  end

  @button_classes = "btn btn-default btn-success button_left_margin button_bottom_margin"

  movies_query = "SELECT movies.id,movies.title,movies.year,movies.rating,genres.name AS genre,studios.name AS studio
                  FROM movies
                    JOIN studios ON movies.studio_id = studios.id
                    JOIN genres ON movies.genre_id = genres.id
                  #{@search_query}
                  ORDER BY movies.#{@order}"

  @movies = db_connection do |conn|
              conn.exec(movies_query)
            end

  erb :'movies/index'
end


get '/movies/:id' do
  @movie_id = params[:id]
  movie_studios_query = "SELECT movies.id,movies.title AS movie,movies.year,movies.rating,
                        genres.name AS genre,
                        studios.name AS studio
                  FROM movies
                    LEFT OUTER JOIN studios ON movies.studio_id = studios.id
                    JOIN genres ON movies.genre_id = genres.id
                  WHERE movies.id = $1"
  cast_members_actors_query = "SELECT movies.id,
                        cast_members.character AS role,
                        actors.name AS actor, actors.id AS actor_id
                  FROM movies
                    LEFT OUTER JOIN cast_members ON movies.id = cast_members.movie_id
                    LEFT OUTER JOIN actors ON actors.id = cast_members.actor_id
                  WHERE movies.id = $1"

  @movies_info = db_connection do |conn|
                    conn.exec_params(movie_studios_query, [@movie_id])
                  end
  @cast_actors_info = db_connection do |conn|
                    conn.exec_params(cast_members_actors_query, [@movie_id])
                  end

  @title = "#{@movies_info[0]["movie"]}"
  @movie_hash = rotten_tomatoes_movie_hash(@title)
  @poster_url = @movie_hash["movies"][0]["posters"]["profile"]
  @rottentomatoes_critic = @movie_hash["movies"][0]["ratings"]["critics_score"]
  @rottentomatoes_audience = @movie_hash["movies"][0]["ratings"]["audience_score"]

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
