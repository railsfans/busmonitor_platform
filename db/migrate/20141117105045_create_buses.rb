class CreateBuses < ActiveRecord::Migration
  def self.up
    create_table :buses do |t|
      t.string :updatetime
      t.integer :updatecount
      t.integer :totalcount
      t.string :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :buses
  end
end
