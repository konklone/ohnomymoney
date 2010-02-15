class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.integer :balance
      t.integer :account_id, :user_id
      t.date :date_of
      t.timestamps
    end
  end
  
  def self.down
    drop_table :days
  end
end