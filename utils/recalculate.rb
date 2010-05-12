# Run this script to recalculate the net worths from scratch, using the existing
# separate account balances as a reference point. Pick one account which has the most complete
# record to use to reference what dates are available from all four accounts.

# Missing days in accounts other than the reference account will effectively count as 0.

# Probably best pasted into IRB instead of run independently.

# use checking account as reference
reference = Account.find 2

dates = reference.balances.all.map {|b| b.date_of}.sort; 1

to_sum = [2,3,4,5]
worth = Account.find 1

dates.each do |date|
  balances = Balance.all :conditions => ["date_of = ? and account_id IN (?)", date, to_sum]
  worth_day = worth.balances.first :conditions => {:date_of => date}
  if worth_day.nil?
    worth_day = worth.balances.new :user_id => 1, :date_of => date
  end
  
  worth_day.amount = balances.map {|balance| balance.amount}.sum
  worth_day.save!
end

dates.first
