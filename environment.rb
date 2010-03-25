require 'rubygems'
require 'sinatra'

require 'active_record'
require 'models'

configure do
  database = YAML.load_file 'config/database.yml'
  environment = Sinatra::Application.environment
  ActiveRecord::Base.establish_connection database[environment]
end