#!/usr/bin/ruby

require 'rubygems'
require File.join(File.dirname(__FILE__), 'wesabe')

class Updater
  attr_accessor :user
  attr_accessor :wesabe
  attr_accessor :maps
  attr_accessor :manual
  
  def initialize(user)
    wesabe = YAML.load_file File.join(File.dirname(__FILE__), 'wesabe.yml')
    self.user = user
    self.wesabe = Wesabe.new
    self.maps = wesabe[:accounts]
    self.manual = wesabe[:manual]
  end
  
  def update_accounts!
    worth = 0
    
    # the accounts in Buxfer
    wesabe.accounts.map do |remote|
      map = maps.find {|m| m[:remote_id] == remote[:id]}
      if map
        account = user.accounts.find map[:local_id]
        amount = (remote[:balance] * 100).to_i # convert to pennies
        amount *= -1 if account.debts?
        
        worth += amount
        update_account! account, amount
      end
    end
    
    # the manual accounts that Buxfer doesn't support
    manual.each do |map|
      account = user.accounts.find map[:local_id]
      amount = map[:amount]
      
      worth += amount
      update_account! account, amount
    end
    
    # the net worth of it all
    account = user.accounts.worth.first
    update_account! account, worth
  end
  
  # idempotent - will overwrite balance if one exists for today
  def update_account!(account, amount)
    balance = account.balances.find_or_initialize_by_date_of Time.now.to_date
    balance.user_id = user.id
    balance.amount = amount
    balance.save!
    puts "Updated #{account.name} with balance of #{amount}, for #{balance.date_of}."
  end
end