class AddSourceId < ActiveRecord::Migration
  def self.up
    add_column "stories", "source_id", :integer
  end

  def self.down
    remove_column "stories", "source_id"
  end
end
