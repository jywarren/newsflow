class AddSource < ActiveRecord::Migration
  def self.up
    add_column "stories", "source", :string, :default => ''
  end

  def self.down
    remove_column "stories", "source"
  end
end
