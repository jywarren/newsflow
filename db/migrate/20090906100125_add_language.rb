class AddLanguage < ActiveRecord::Migration
  def self.up
    add_column "stories", "language", :string, :default => 'en'
    add_column "sources", "language", :string, :default => 'en'
  end

  def self.down
    remove_column "stories", "language"
    remove_column "sources", "language"
  end
end
