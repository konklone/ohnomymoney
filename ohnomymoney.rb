#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'environment'

require 'erb'
require 'charting'

# For now, have the root URL act as if we visited the userpage of the first user
before do
  if request.path_info == '/'
    request.path_info = "/#{User.first.handle}" 
  elsif request.path_info == '/worth.xml'
    request.path_info = "/#{User.first.handle}/worth.xml"
  end
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

get "/:handle/account/:id" do
  halt 404 unless user = User.find_by_handle(params[:handle])
  halt 404 unless account = user.accounts.find(params[:id])
  
  erb :account, :locals => {
    :user => user,
    :account => account,
    :oldest => account.balances.first(:order => "created_at ASC"),
    :newest => account.balances.first(:order => "created_at DESC"),
    :balances => account.balances.all(:limit => 180)
  }
end

get "/:handle/worth.xml" do
  headers['Content-Type'] = 'application/rss+xml'
  "<?xml><xml/>"
end

helpers do
  
  def date(date)
    date.strftime("%B ") + date.strftime("%d").gsub(/^0/, "")
  end
  
  def direction(balance)
    balance >= 0 ? 'positive' : 'negative'
  end
  
  def format_amount(amount)
    number = amount.to_f / 100
    parts = ("%01.2f" % number).split('.')
    answer = '$' + number_with_delimiter(parts[0]) + '.' + parts[1].to_s
    if number > 0
      answer = '+' + answer
    elsif number < 0
      answer = '-' + answer
    end
    answer
  end
  
end