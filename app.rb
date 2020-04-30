require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'tempfile'
require 'sinatra/json'
require './models/contribution.rb'

before do
  Dotenv.load
  Cloudinary.config do |config|
    config.cloud_name = ENV['CLOUD_NAME']
    config.api_key= ENV['CLOUDINARY_API_KEY']
    config.api_secret= ENV['CLOUDINARY_API_SECREAT']
  end
end

get '/' do
  @contents = Contribution.all.order('id desc')
  erb :index
end

get '/edit/:id' do
  @content = Contribution.find(params[:id])
  erb :edit
end

post '/new' do
  img_url = ''
  if params[:file] != "" then
    img = params[:file]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    img_url = upload['url']
  end
  Contribution.create({
    name: params[:user_name],
    body: params[:body],
    good: 0,
    img: img_url
  })
  redirect '/'
end

post '/delete/:id' do
  Contribution.find(params[:id]).destroy
  redirect '/'
end

post '/renew/:id' do
  content = Contribution.find(params[:id])
  content.update({
    name: params[:user_name],
    body: params[:body]
  })
  redirect '/'
end

post '/good/:id' do
  content = Contribution.find(params[:id])
  good = content.good
  content.update({
    good: good + 1
  })
  redirect '/'
end