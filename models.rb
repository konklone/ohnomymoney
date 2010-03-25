class Balance < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  
  validates_presence_of :account_id, :user_id, :amount, :date_of
end

class Account < ActiveRecord::Base
  TYPES = %w( worth assets debts )
  
  belongs_to :user
  has_many :balances
  
  validates_presence_of :name, :if => :needs_name
  validates_presence_of :user_id
  validates_inclusion_of :account_type, :in => TYPES
  
  named_scope :worth, :conditions => {:account_type => 'worth'}
  named_scope :assets, :conditions => {:account_type => 'assets'}
  named_scope :debts, :conditions => {:account_type => 'debts'}
  
  def assets?
    account_type == 'credit'
  end
  
  def debts?
    account_type == 'debts'
  end
  
  def needs_name
    account_type != 'worth'
  end
  
  def amount
    balances.count > 0 ? balances.first(:order => "created_at DESC").amount : 0
  end
end

class User < ActiveRecord::Base
  has_many :accounts
  
  validates_presence_of :email, :handle, :name
  validates_uniqueness_of :email, :handle
end