class AddNeverOnlineCountToBus < ActiveRecord::Migration
  def self.up
    add_column :buses, :never_online_count, :integer
    add_column :buses, :pass_48h_never_online_count, :integer
    add_column :buses, :pass_24h_update_rate, :float
    add_column :buses, :pass_48h_update_rate, :float
  end

  def self.down
    remove_column :buses, :pass_48h_update_rate
    remove_column :buses, :pass_24h_update_rate
    remove_column :buses, :pass_48h_never_online_count
    remove_column :buses, :never_online_count
  end
end
