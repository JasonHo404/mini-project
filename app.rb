require "sinatra"
require "sinatra/reloader"
require "http"
require "json"


get("/") do
erb(:home)
end

get('/output') do

  
  ENV.fetch("GMAPS_KEY") 
  gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + params.fetch("location") +"&key=" + ENV.fetch("GMAPS_KEY") 


  raw_response = HTTP.get(gmap_url)

  @parsed_response = JSON.parse(raw_response)

  @results = @parsed_response.fetch("results")

  @first_result = @results.at(0)

  @geo = @first_result.fetch("geometry")

  @loc = @geo.fetch("location")

  @lat = @loc.fetch("lat")

  @long = @loc.fetch("lng")


  ENV.fetch("KEY") 


  erb(:location)
end
