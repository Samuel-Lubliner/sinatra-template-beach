require 'sinatra'
require 'http'
require 'json'

get '/' do
  erb :about
end

get '/about' do
  erb :about
end


get '/prediction' do

  current_date = Time.now.strftime('%Y-%m-%d')

  response = HTTP.get("https://data.cityofchicago.org/resource/xvsz-3xcj.json?date=#{current_date}")

  beaches_data = JSON.parse(response.to_s)

  @beaches = beaches_data.sort_by { |beach| beach["predicted_level"].to_f }

  erb :beach_prediction
end
