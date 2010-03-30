#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'net/http'
require 'net/https'
require 'uri'

class Buxfer
  attr_accessor :token
  
  def initialize(email, password)
    self.token = token_for email, password
  end
  
  def get(command, query_string)
    http = Net::HTTP.new 'www.buxfer.com', 443
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    resp, data = http.get "/api/#{command}.json?#{query_string}", nil

    result = JSON.parse data
    response = result['response']
    
    if response['status'] != 'OK'
      puts "Error: #{response['status'].gsub(/ERROR: /, '')}"
      exit
    end

    response
  end

  def token_for(email, password)
    response = get 'login', "userid=#{email}&password=#{password}"
    response ? response['token'] : nil
  end
  
  def accounts
    response = get 'accounts', "token=#{token}"
    response ? response['accounts'] : nil
  end

end