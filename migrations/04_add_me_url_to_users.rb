class AddMeUrlToUsers < ActiveRecord::Migration
  
  def self.up
    add_column :users, :me_url, :string
    add_index :users, :me_url
  end
  
  def self.down
    remove_column :users, :me_url
  end
  
end