class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name, :account_type
      t.integer :user_id
      
      t.timestamps
    end
    
    add_index :accounts, [:user_id, :account_type]
    add_index :accounts, :user_id
    add_index :accounts, :account_type
  end
  
  def self.down
    drop_table :accounts
  end
end