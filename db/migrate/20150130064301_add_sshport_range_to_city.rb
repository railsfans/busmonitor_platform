class AddSshportRangeToCity < ActiveRecord::Migration
  def self.up
    add_column :cities, :sshport_range, :string, :default=>','
  end

  def self.down
    remove_column :cities, :sshport_range
  end
end
