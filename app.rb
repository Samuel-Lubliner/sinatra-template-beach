require 'sinatra'
require 'http'
require 'json'
require 'date'

get '/' do
  erb :about
end

get '/about' do
  erb :about
end

get '/prediction' do
  today = Date.today
  url = "https://data.cityofchicago.org/resource/xvsz-3xcj.json?date=#{today}"

  response = HTTP.get(url)
  data = JSON.parse(response.body.to_s)

  if data.empty? # If today's data is not available, get yesterday's data
    yesterday = today - 1
    url = "https://data.cityofchicago.org/resource/xvsz-3xcj.json?date=#{yesterday}"
    response = HTTP.get(url)
    data = JSON.parse(response.body.to_s)
  end

  @beaches = data.sort_by { |beach| beach["predicted_level"].to_f } 

  erb :beach_prediction
end
