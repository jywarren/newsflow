class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|

      t.string :category, :default => ''
      t.string :title, :default => ''
      t.string :guid, :default => ''
      t.text :description, :default => ''
      t.string :link, :default => ''
      
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
