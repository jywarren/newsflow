class Newsflow

  # this is run every time a request is made with after_filter in application.rb
  def self.run_import
    interval = 10
    last_story = Story.find(:last)
    last_story = last_story.created_at.to_f unless last_story.nil?
    last_story ||= 0
    # check if this has been run in the last <interval> seconds
    if DateTime.now.to_f - last_story > interval
      # system "curl http://"
      Newsflow.import
      puts 'Imported 30 articles from Google News'
    else
      puts 'Attempted googlenews import but '+interval.to_s+' seconds have not passed since last import'
    end
  end

  def self.import(num = 5)
    Googlenews.items(num).each do |report|
      name = report['title'].match(/ - ([\w. ]+)/)[1]
      source = Source.find_by_name(name)
      begin
        if source
          source.count = source.count+1
          if source.lat != 0 && source.lon != 0
            report['lon'] = source.lon
            report['lat'] = source.lat
            report['source'] = source.name
            report['location'] = source.place
          end
          story = Story.new({ :title => report['title'],
                              :category => report['category'],
                              :guid => report['guid'],
                              :description => report['description'],
                              :link => report['link']})# ,
                              #                             :source => source.name})
          if source.place
            story.source_id = source.id
          end
          story.save!
          if report['places']
            # generate foreign records for each place, store the ids in the story record:
            if report['places'].is_a?(Array)
              places = report['places']
            else
              places = [report['places']]
            end
            places.each do |place|
              place = place['place']
              puts place['name']
              new_place = Place.find_by_name(place['name'],:conditions => {:lat => place['centroid']['latitude'], :lon => place['centroid']['longitude']})
              if new_place.nil?
                new_place = Place.new({
                  :name => place['name'],
                  :lat => place['centroid']['latitude'],
                  :lon => place['centroid']['longitude']
                })
                new_place.save
              end
              story_place = StoryPlace.new({
                :story_id => story.id,
                :place_id => new_place.id
              })
              story_place.save
            end
          else
            puts 'no places'
          end
        else
          # unless we have that source, we cannot add the story... 
          # we'd be unable to draw it!
          source = Source.new({
            :name => name,
            :link => report['link']
          })
          source.save
        end
      rescue
        puts "duplicate story"
      end
    end
  end
  
end