class AddEmailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :users, :phone, :string
    add_column :users, :sex, :boolean
    add_column :users, :realname, :string
  end

  def self.down
    remove_column :users, :realname
    remove_column :users, :sex
    remove_column :users, :phone
    remove_column :users, :email
  end
end
