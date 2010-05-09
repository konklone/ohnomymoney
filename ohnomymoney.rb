#!/usr/bin/env ruby

# Dreamhost has some special...I don't want to talk about it
begin
  require 'dreamhost'
rescue LoadError
end

require 'rubygems'
require 'sinatra'
require 'environment'

# front-end specific requires
require 'erb'


# For now, have the root URL act as if we visited the userpage of the first user
before do
  @user = User.first
  if request.path_info !~ /^\/#{@user.handle}/
    request.path_info = "/#{@user.handle}" + request.path_info
  end
end

get "/:handle/?" do
  halt 404 unless user = @user #User.find_by_handle(params[:handle])
  
  erb :index, :locals => {
    :user => user, 
    :worth => user.accounts.worth.first, 
    :assets => user.accounts.assets.all, 
    :debts => user.accounts.debts.all
  }
end

get "/:handle/account/:id/?" do
  halt 404 unless user = @user # User.find_by_handle(params[:handle])
  halt 404 unless account = user.accounts.find(params[:id])
  
  erb :account, :locals => {
    :user => user,
    :account => account,
    :balances => account.balances.all(:order => "created_at ASC")
  }
end

get "/:handle/worth.xml" do
  halt 404 unless user = @user # User.find_by_handle(params[:handle])
  halt 404 unless account = user.accounts.worth.first
  
  response['Content-Type'] = 'application/rss+xml'
  erb :worth, :locals => {
    :user => user,
    :account => account,
    :balances => account.balances.all(:limit => 10, :order => "created_at DESC")
  }
end

helpers do
  
  def date(date)
    date.strftime("%B ") + date.strftime("%d").gsub(/^0/, "")
  end
  
  def long_date(date)
    date.strftime("%B ") + date.strftime("%d").gsub(/^0/, "") + ", #{date.strftime "%Y"}"
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
  
  def midnight_stamp(date)
    date.strftime "%a, %d %b %Y 00:00:00 EST"
  end
  
  def number_with_delimiter(number)
    number = number.to_i.abs
    parts = number.to_s.split('.')
    parts[0].gsub! /(\d)(?=(\d\d\d)+(?!\d))/, "\\1,"
    parts.join '.'
  end
  
end