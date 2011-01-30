class AddSourceCount < ActiveRecord::Migration
  def self.up
    add_column "sources", "count", :integer, :default => 0
  end

  def self.down
    remove_column "sources", "count"
  end
end
