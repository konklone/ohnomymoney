class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :name, :handle, :url
      t.timestamps
    end
    
    add_index :users, :email
    add_index :users, :handle
  end
  
  def self.down
    drop_table :users
  end
end