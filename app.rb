require "sinatra"
require "sinatra/reloader"
require 'http'
require 'json'


get("/") do
erb(:home)
end

get('/output') do

  
  ENV.fetch("GMAPS_KEY") 
  gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + params.fetch("location") +"&key=" + ENV.fetch("GMAPS_KEY") 


  raw_response = HTTP.get(gmap_url)
  @parsed_response = JSON.parse(raw_response)
  ENV.fetch("SKY_KEY") 
  erb(:location)
end
