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


def return_actor_info(array_of_hashes, target_key, target_value)
  array_of_hashes.each do |nested_hash|
    if nested_hash[target_key] == target_value
      puts "hash: #{nested_hash}"
      return nested_hash
    end
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

  actor_query = "SELECT actors.id,actors.name,movies.title AS movie,cast_members.character AS role
                 FROM actors
                  JOIN cast_members ON actors.id = cast_members.actor_id
                  JOIN movies ON cast_members.movie_id = movies.id"

  @actor_info = db_connection do |conn|
              conn.exec(actor_query)
            end

  @one_actor_hash = return_actor_info(@actor_info, "id", @id)
  @title = "#{@one_actor_hash["name"]}"

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
