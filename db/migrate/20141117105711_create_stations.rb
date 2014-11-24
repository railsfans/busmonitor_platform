class CreateStations < ActiveRecord::Migration
  def self.up
    create_table :stations do |t|
      t.string :station_name
      t.string :station_num
      t.string :online_state
      t.string :online_time
      t.string :offline_time
      t.string :offline_count
      t.string :update_percent
      t.string :update_speed
      t.string :sync_state
      t.string :server_state
      t.string :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stations
  end
end
