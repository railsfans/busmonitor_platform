class AddStationIdToStation < ActiveRecord::Migration
  def self.up
    add_column :stations, :station_id, :integer
  end

  def self.down
    remove_column :stations, :station_id
  end
end
