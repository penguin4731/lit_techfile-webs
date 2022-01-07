require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require "net/http"
require "uri"

get '/:keyword' do
  base_url = 'https://lit-wikipedia-api.herokuapp.com/?keyword='
  if params[:keyword]
    keyword = params[:keyword]
    url = URI.parse(base_url + keyword)
    @result = Net::HTTP.get(url).force_encoding("utf-8")
  end
  erb :index
end