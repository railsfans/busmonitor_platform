class AddDeployToCity < ActiveRecord::Migration
  def self.up
    add_column :cities, :deploy_time, :string
    add_column :cities, :deploy_status, :string, :default=>0
  end

  def self.down
    remove_column :cities, :deploy_status
    remove_column :cities, :deploy_time
  end
end
