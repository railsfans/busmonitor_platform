class RenameColumnOfStation < ActiveRecord::Migration
  def self.up
	rename_column :stations, :server_state, :service_state
  end

  def self.down
	rename_column :stations, :service_state, :server_state
  end
end
