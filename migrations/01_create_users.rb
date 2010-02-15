class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :name
      t.timestamps
    end
    
    add_index :users, :email
  end
  
  def self.down
    drop_table :users
  end
end