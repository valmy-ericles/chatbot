require 'json'
require 'sinatra'
require 'sinatra/activerecord'
require './config/database'

Dir['./app/models/*.rb'].sort.each { |file| require file }

class App < Sinatra::Base
  get '/' do
    'Hello World!'
  end
end
