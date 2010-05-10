require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'

gem 'activerecord', '=2.3.5'
require 'active_record'
require 'models'

configure do
  database = YAML.load_file 'config/database.yml'
  environment = Sinatra::Application.environment
  ActiveRecord::Base.establish_connection database[environment]
end