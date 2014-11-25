class AddLoginipToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :loginip, :string
    add_column :users, :logintime, :string
    add_column :users, :logincity, :string
    add_column :users, :new_token, :string
  end

  def self.down
    remove_column :users, :logintime
    remove_column :users, :loginip
    remove_column :users, :logincity
    remove_column :users, :new_token
  end
end
