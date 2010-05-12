# If you make #{account_id}.yml with keys of dates, and values of amounts, 
# this script will update the balances for that account in place, creating new days
# where needed. It's idempotent, run it as many times as you want.
# Might be best just pasted into irb when you want to run it.

# Set the account_id here before running
account_id = 5



days = YAML.load_file "#{account_id}.yml"; 1

account = Account.find account_id

days.each do |day, amount|
  balance = account.balances.first :conditions => {:date_of => day}
  if balance.nil?
    balance = account.balances.new :user_id => 1, :date_of => day
  end
  
  balance.amount = amount
  balance.save!
end

Balance.count