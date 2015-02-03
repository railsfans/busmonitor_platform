class AddBackupToCity < ActiveRecord::Migration
  def self.up
    add_column :cities, :backup_status, :integer, :default=>0
    add_column :cities, :backup_time, :string
  end

  def self.down
    remove_column :cities, :backup_time
    remove_column :cities, :backup_status
  end
end
