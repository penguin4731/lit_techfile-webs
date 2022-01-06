require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
end

get '/' do
  'こんにちは'
end

get '/count' do
  @number = Count.first.number
  erb:index
end

post '/plus' do
  count = Count.first
  count.number = count.number + 1
  count.save
  redirect '/count'
end

post '/minus' do
  count = Count.first
  count.number = count.number - 1
  count.save
  redirect '/count'
end

post '/multiplication' do
  count = Count.first
  count.number = count.number * 2
  count.save
  redirect '/count'
end

post '/division' do
  count = Count.first
  count.number = count.number / 2
  count.save
  redirect '/count'
end

post '/zero' do
  count = Count.first
  count.number = 0
  count.save
  redirect '/count'
end