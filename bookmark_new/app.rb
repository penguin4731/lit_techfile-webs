require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require "sinatra/json"

require './models/bookmark.rb'


get '/' do
  @bookmarks = Bookmark.all
  erb :index
end

post '/create' do
  Bookmark.create(title: params[:title], url: params[:url])
  redirect '/'
end