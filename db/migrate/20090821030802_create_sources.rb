class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|

      t.string :name, :default => ''
      t.string :place, :default => ''
      t.decimal  "lat",         :precision => 20, :scale => 10, :default => 0.0
      t.decimal  "lon",         :precision => 20, :scale => 10, :default => 0.0

      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
