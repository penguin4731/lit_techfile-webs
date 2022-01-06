require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/answer.rb'
require 'csv'

use Rack::Session::Cookie

get '/' do
  erb :index
end

get '/confirm' do
  @name = session[:name]
  @email = session[:email]
  @gender = session[:gender]
  @color = session[:color]
  @free_text = session[:free_text]

  erb :confirm
end

post '/new' do
  Answer.create({
    name: session[:name],
    email: session[:email],
    gender: session[:gender],
    color: session[:color],
    free_text: session[:free_text]
  })
  redirect '/finish'
end

post '/confirm' do
  session[:name] = params[:name]
  session[:email] = params[:email]
  session[:gender] = params[:gender]
  session[:color] = params[:color]
  session[:free_text] = params[:free_text]
  redirect '/confirm'
end

get '/finish' do
  erb :finish
end

get '/list' do
  @answers = Answer.all
  erb :list
end