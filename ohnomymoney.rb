#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'environment'

require 'erb'
require 'charting'

# For now, have the root URL act as if we visited the userpage of the first user
before do
  request.path_info = "/#{User.first.handle}" if request.path_info == '/'
end

get "/:handle" do
  halt 404 unless user = User.find_by_handle(params[:handle])
  
  erb :index, :locals => {
    :user => user, 
    :worth => user.accounts.worth.first, 
    :assets => user.accounts.assets.all, 
    :debts => user.accounts.debts.all
  }
end