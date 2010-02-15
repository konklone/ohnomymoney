class Day < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  
  validates_presence_of :account_id, :user_id, :balance, :date_of
end

class Account < ActiveRecord::Base
  TYPES = %w( worth balance )
  
  belongs_to :user
  has_many :days
  
  validates_presence_of :name, :if => :needs_name
  validates_presence_of :user_id
  validates_inclusion_of :account_type, :in => TYPES
  
  def needs_name
    account_type == 'balance'
  end
end

class User < ActiveRecord::Base
  has_many :accounts
  
  validates_presence_of :email, :name
  validates_uniqueness_of :email
end