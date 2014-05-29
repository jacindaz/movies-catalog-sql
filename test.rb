test = [{"id"=>"15", "name"=>"Michael Stephenson", "title"=>"Troll 2", "character"=>"Joshua"},
  {"id"=>"17", "name"=>"Gary Carison", "title"=>"Troll 2", "character"=>"Sheriff Freak"},
  {"id"=>"20", "name"=>"David McConnell", "title"=>"Troll 2", "character"=>"Brent"},
  {"id"=>"21", "name"=>"Connie McFarland", "title"=>"Troll 2", "character"=>"Holly"},
  {"id"=>"22", "name"=>"Robert Ormsby", "title"=>"Troll 2", "character"=>"Seth"},
  {"id"=>"26", "name"=>"Jason Wright", "title"=>"Troll 2", "character"=>"Elliott"},
  {"id"=>"29", "name"=>"Gwyneth Paltrow", "title"=>"The Royal Tenenbaums", "character"=>"Margot Tenenbaum"},
  {"id"=>"30", "name"=>"Ben Stiller", "title"=>"The Royal Tenenbaums", "character"=>"Chas Tenenbaum"},
  {"id"=>"31", "name"=>"Bill Murray", "title"=>"The Royal Tenenbaums", "character"=>"Raleigh St. Clair"},
  {"id"=>"32", "name"=>"Anjelica Huston", "title"=>"The Royal Tenenbaums", "character"=>"Etheline Tenenbaum"},
  {"id"=>"34", "name"=>"Owen Wilson", "title"=>"The Royal Tenenbaums", "character"=>"Eli Cash"},
  {"id"=>"31", "name"=>"Bill Murray", "title"=>"The Life Aquatic with Steve Zissou", "character"=>"Steve Zissou"},
  {"id"=>"34", "name"=>"Owen Wilson", "title"=>"The Life Aquatic with Steve Zissou", "character"=>"Ned Plimpton"},
  {"id"=>"32", "name"=>"Anjelica Huston", "title"=>"The Life Aquatic with Steve Zissou", "character"=>"Eleanor Zissou"},
  {"id"=>"53", "name"=>"Willem Dafoe", "title"=>"The Life Aquatic with Steve Zissou", "character"=>"Klaus Daimler"},
  {"id"=>"55", "name"=>"Michael Gambon", "title"=>"The Life Aquatic with Steve Zissou", "character"=>"Oseary Drakoulias"}]


movies_test = [{"id"=>"880", "title"=>"*batteries not included", "year"=>"1987", "rating"=>"64", "genre"=>"Kids & Family", "studio"=>"Universal Pictures"},
{"id"=>"948", "title"=>"10 Things I Hate About You", "year"=>"1999", "rating"=>"61", "genre"=>"Comedy", "studio"=>"Buena Vista Pictures"},
{"id"=>"3204", "title"=>"10,000 B.C.", "year"=>"2008", "rating"=>"8", "genre"=>"Drama", "studio"=>"Warner Bros. Pictures"},
{"id"=>"2872", "title"=>"10.5", "year"=>"2004", "rating"=>nil, "genre"=>"Drama", "studio"=>"LionsGate Entertainment"},
{"id"=>"881", "title"=>"101 Dalmatians", "year"=>"1961", "rating"=>"97", "genre"=>"Animation", "studio"=>"Buena Vista"},
{"id"=>"2364", "title"=>"101 Dalmatians", "year"=>"1996", "rating"=>"39", "genre"=>"Action & Adventure", "studio"=>"Buena Vista Pictures"},
{"id"=>"1569", "title"=>"102 Dalmatians", "year"=>"2000", "rating"=>"31", "genre"=>"Comedy", "studio"=>"Buena Vista Pictures"},
{"id"=>"2118", "title"=>"11-11-11", "year"=>"2011", "rating"=>"8", "genre"=>"Drama", "studio"=>"Rocket Releasing"},
{"id"=>"3064", "title"=>"12 Angry Men", "year"=>"1997", "rating"=>"92", "genre"=>"Drama", "studio"=>"Orion Home Video"},
{"id"=>"3366", "title"=>"12 Rounds", "year"=>"2009", "rating"=>"29", "genre"=>"Mystery & Suspense", "studio"=>"20th Century Fox"}]

def return_actor_info(array_of_hashes, target_key, target_value)
  actor_movies = []
  array_of_hashes.each do |nested_hash|
    if nested_hash[target_key] == target_value
      actor_movies << nested_hash
    end
  end
  puts "Movies: #{actor_movies}"
  return actor_movies
end
return_actor_info(movies_test, "id", "881")



test_api_hash = {"total"=>1, "movies"=>[{"id"=>"10180", "title"=>"10 Things I Hate About You", "year"=>1999, "mpaa_rating"=>"PG-13", "runtime"=>97, "critics_consensus"=>"Julia Stiles and Heath Ledger add strong performances to an unexpectedly clever script, elevating 10 Things (slightly) above typical teen fare.", "release_dates"=>{"theater"=>"1999-03-31", "dvd"=>"1999-10-12"}, "ratings"=>{"critics_rating"=>"Fresh", "critics_score"=>61, "audience_rating"=>"Upright", "audience_score"=>69}, "synopsis"=>"", "posters"=>{"thumbnail"=>"http://content8.flixster.com/movie/11/15/34/11153458_mob.jpg", "profile"=>"http://content8.flixster.com/movie/11/15/34/11153458_pro.jpg", "detailed"=>"http://content8.flixster.com/movie/11/15/34/11153458_det.jpg", "original"=>"http://content8.flixster.com/movie/11/15/34/11153458_ori.jpg"}, "abridged_cast"=>[{"name"=>"Heath Ledger", "id"=>"162652588", "characters"=>["Patrick Verona"]}, {"name"=>"Julia Stiles", "id"=>"162660056", "characters"=>["Katarina Stratford"]}, {"name"=>"Joseph Gordon-Levitt", "id"=>"162666960", "characters"=>["Cameron James"]}, {"name"=>"Larisa Oleynik", "id"=>"382254460", "characters"=>["Bianca Stratford"]}, {"name"=>"David Krumholtz", "id"=>"162656172", "characters"=>["Michael Eckman"]}], "alternate_ids"=>{"imdb"=>"0147800"}, "links"=>{"self"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/10180.json", "alternate"=>"http://www.rottentomatoes.com/m/10_things_i_hate_about_you/", "cast"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/10180/cast.json", "clips"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/10180/clips.json", "reviews"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/10180/reviews.json", "similar"=>"http://api.rottentomatoes.com/api/public/v1.0/movies/10180/similar.json"}}], "links"=>{"self"=>"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q=10+Things+I+Hate+About+You&page_limit=1&page=1"}, "link_template"=>"http://api.rottentomatoes.com/api/public/v1.0/movies.json?q={search-term}&page_limit={results-per-page}&page={page-number}"}




