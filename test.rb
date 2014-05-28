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
return_actor_info(test, "id", "31")


