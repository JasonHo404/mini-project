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

  @results = @parsed_response.fetch("results")

  @first_result = @results.at(0)

  @geo = @first_result.fetch("geometry")

  @loc = @geo.fetch("location")

  @lat = @loc.fetch("lat")

  @long = @loc.fetch("lng")


  ENV.fetch("KEY") 
  erb(:location)
  uri = URI("https://api.astronomyapi.com/api/v2/studio/star-chart")

  x = HTTP.auth('Basic YjRhYjc1YzUtNjVjYy00NWQ5LWFjNzAtYWNiYWFlMjk2MmNmOmMyNzFmMjgyZjNlZTM5ZWRhNzZmMTQ1ZDU2NDc1OTI2NzZhZThmNDExNjNjZjBkNTNmNmNhMGU3MjkxOThhYjc4YmQxNzI0Mzg5MTIyMjMzZDk1OWYyODkwMmYyMGU5OTVjMzljYThkOWJhYTgwNzk0NjhmNjA3MzRmMDk3YjkxYWE0ZGRkMWU5NGQwYjg0MWY2MTFiYmU0ODZhNzBmY2UzMWZiZGM0NDRkYWJmMzUyYmZhNmE3M2JmZTRkZjZkMzk0ZWVmYzE2MjdmNjg3NGFhNjA1Y2NiOWIyZDMwMGQ1')



  body = "{\"style\":\"navy\",\"observer\":{\"latitude\":33.775867,\"longitude\":-84.39733,\"date\":\"2023-09-22\"},\"view\":{\"type\":\"area\",\"parameters\":{\"position\":{\"equatorial\":{\"rightAscension\":0,\"declination\":0}},\"zoom\":\"0\"}}}"

  response = HTTP.post(uri, :params => {:Authorization => x, :body => body })

  
end
