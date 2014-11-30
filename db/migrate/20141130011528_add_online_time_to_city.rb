class AddOnlineTimeToCity < ActiveRecord::Migration
  def self.up
	add_column :cities, :online_state, :integer
	add_column :cities, :online_time, :string
	add_column :cities, :offline_time, :string
  end

  def self.down
	remove_column :cities, :online_state
	remove_column :cities, :online_time
	remove_column :cities, :offline_time
  end
end
