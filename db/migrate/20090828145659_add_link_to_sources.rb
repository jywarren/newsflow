class AddLinkToSources < ActiveRecord::Migration
  def self.up
    add_column "sources", "link", :string
  end

  def self.down
    remove_column "sources", "link"
  end
end
