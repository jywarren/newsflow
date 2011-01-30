class CreateStoryPlaces < ActiveRecord::Migration
  def self.up
    create_table :story_places do |t|

      t.integer  "story_id", :default => 0
      t.integer  "place_id", :default => 0

    end
    # convert story.places to individual story_place records
    stories = Story.find :all
    stories.each do |story|
      story.places.split(',').each do |place|
        story_place = StoryPlace.new({
          :place_id => place,
          :story_id => story.id
        })
        story_place.save
      end
    end
    
    remove_column "stories", "places"
  end

  def self.down
    add_column "stories", "places", :string, :default => ''    
    
    # rewrite story.places from individual story_place records
    stories = Story.find :all
    stories.each do |story|
      story_places = StoryPlace.find_all_by_story_id(story.id)

      places = []
      story_places.each do |story_place|
        places << story_place.place_id
      end
      story.places = places.join(',')
      story.save
    end
    
    drop_table :story_places
  end
end
