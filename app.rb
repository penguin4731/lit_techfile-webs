require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/answer.rb'
require 'csv'

use Rack::Session::Cookie

