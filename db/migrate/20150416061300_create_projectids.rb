class CreateProjectids < ActiveRecord::Migration
  def self.up
    create_table :projectids do |t|
      t.string :code_first, :default=>'00'
      t.string :code_second, :default=>'00'
      t.string :code_third, :default=>'00'
      t.string :code_four, :default=>'00'
      t.string :code_five, :default=>'00'
      t.string :name, :default=>'root'
      t.integer :parent_id, :default=>0
      t.integer :rank, :default=>0

      t.timestamps
    end
  end

  def self.down
    drop_table :projectids
  end
end
