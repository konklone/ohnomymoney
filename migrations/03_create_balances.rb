class CreateBalances < ActiveRecord::Migration
  def self.up
    create_table :balances do |t|
      t.integer :amount
      t.integer :account_id, :user_id
      t.date :date_of
      t.timestamps
    end
    add_index :balances, :account_id
    add_index :balances, :user_id
  end
  
  def self.down
    drop_table :balances
  end
end