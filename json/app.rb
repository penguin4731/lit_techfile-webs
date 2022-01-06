require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'open-uri'
require 'net/http'
require 'json'

require './models.rb'

get '/' do
  erb :index
end

get '/search' do
  keyword = params[:keyword]
  uri = URI("https://itunes.apple.com/search")
  uri.query = URI.encode_www_form({term: keyword, country: "US", media: "music", limit:"10"})
  res = Net::HTTP.get_response(uri)
  returned_json = JSON.parse(res.body)

  returned_json["results"].map! do |music|
    music_info = Music.find_or_create_by(track_id: music["trackId"])
    music["id"] = music_info.id
    music["like"] = music_info.like
    music
  end

  @musics = returned_json["results"]

  json returned_json["results"]
end

post '/music/:id/like' do
  music = Music.find(params[:id])
  music.like = music.like + 1
  music.save

  music.like.to_s
end