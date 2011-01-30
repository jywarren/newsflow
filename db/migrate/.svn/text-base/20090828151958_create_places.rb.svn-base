class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      
      t.string :name, :default => ''
      t.string :full, :default => ''
      t.decimal  "lat",         :precision => 20, :scale => 10, :default => 0.0
      t.decimal  "lon",         :precision => 20, :scale => 10, :default => 0.0

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
