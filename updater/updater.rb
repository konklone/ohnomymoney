# needs the ohnomymoney environment loaded beforehand
require File.join(File.dirname(__FILE__), 'buxfer')

class Updater
  attr_accessor :user
  attr_accessor :buxfer
  attr_accessor :maps
  attr_accessor :manual
  
  def initialize(user)
    buxfer = YAML.load_file File.join(File.dirname(__FILE__), 'buxfer.yml')
    
    self.user = user
    self.buxfer = Buxfer.new buxfer[:credentials][:email], buxfer[:credentials][:password]
    self.maps = buxfer[:accounts]
    self.manual = buxfer[:manual]
  end
  
  def update_accounts!
    worth = 0
    
    # the accounts in Buxfer
    buxfer.accounts.map do |remote|
      map = maps.find {|m| m[:remote_id] == remote['id']}
      if map
        account = user.accounts.find map[:local_id]
        balance = (remote['balance'] * 100).to_i # convert to pennies
        balance *= -1 if account.debts?
        
        worth += balance
        update_account! account, balance
      end
    end
    
    # the manual accounts that Buxfer doesn't support
    manual.each do |map|
      account = user.accounts.find map[:local_id]
      balance = map[:balance]
      
      worth += balance
      update_account! account, map[:balance]
    end
    
    # the net worth of it all
    account = user.accounts.worth.first
    update_account! account, worth
  end
  
  # idempotent - will overwrite balance if one exists for today
  def update_account!(account, balance)
    day = account.days.find_or_initialize_by_date_of Time.now.to_date
    day.user_id = user.id
    day.balance = balance 
    day.save!
    puts "Updated #{account.name} with balance of #{balance}, for #{day.date_of}."
  end
end