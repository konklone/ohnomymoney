#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'environment'

# For now, have the root URL act as if we visited the userpage of the first user
before do
  request.path_info = "/#{User.first.handle}" if request.path_info == '/'
end

get "/:handle" do
  halt 404 unless user = User.find_by_handle(params[:handle])
  
  user.accounts.all.map(&:name).join("<br/>\n")
end

not_found do
  "User not found"
end