class AddPlacesToStoryRemoveFull < ActiveRecord::Migration
  def self.up
    add_column "stories", "places", :string, :default => ''
    remove_column "places", "full"
  end

  def self.down
    add_column "places", "full", :string
    remove_column "stories", "places"
  end
end
