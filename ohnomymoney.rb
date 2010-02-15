#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'environment'

get '/' do
  Account.all.map(&:name).join("<br/>\n")
end