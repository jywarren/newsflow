class DataController < ApplicationController  

  def import
    render :text => Newsflow.import
  end

  def source_list
    render :json => Source.find(:all, :conditions => ['lat != 0 AND lon != 0 AND count > 4']).collect {|source| [source.id,source.lat,source.lon]}
  end

  def sources
    params[:id] ||= 50
    stories = []
    Story.find(:all,:limit => params[:id],:order => 'stories.id DESC', :conditions => ['sources.lon != 0 AND sources.lat != 0'],:include => :source).each do |story|
        place_ids = []
        StoryPlace.find_all_by_story_id(story.id).each do |story_place|
          place_ids << story_place.place_id
          puts story_place.place_id
        end
        story['places'] = Place.find(:all, :conditions => ['id IN (?)',place_ids.join(',')])
        stories << story if story.places
    end
    puts stories.length.to_s+" stories found"
    render :json => stories
  end

  def source
    num = params[:num]
    num = 25 unless params[:num]
    source = Source.find(params[:id])
    stories = Story.find(:all,:order => 'id DESC', :conditions => ['source_id = ?',source.id],:limit => num)
    stories.each do |story|
      story_places = StoryPlace.find_all_by_story_id(story.id)
      place_ids = []
      story_places.each do |story_place|
        place_ids << story_place.place_id
      end
      story['places'] = Place.find(:all, :conditions => ['id IN (?)',place_ids])
    end
    puts stories.length.to_s+" stories found"
    render :json => stories
  end

  def place
    places = Place.find_all_by_name(params[:id])
    # ADD: find nearby with acts_as_mappable or with lat/lon range
    place_ids = []
    places.each do |place|
      place_ids << place.id
    end
    story_places = StoryPlace.find_all_by_place_id(place_ids)
    # story_places = StoryPlace.find(:all,:conditions => ['place_id IS IN ('+place_ids.join(',')+')'])
    # story_places = [story_places] if !story_places.is_a? Array
    story_ids = []
    story_places.each do |story_place|
      story_ids << story_place.story_id
    end
    stories = Story.find(story_ids)#,:conditions => ['lat != 0 AND lon != 0'])
    # REDUNDANT??:
    stories.each do |story|
        story['places'] = Place.find(:all, :conditions => ['id IN (?)',place_ids])
    end
    puts stories.length.to_s+" stories found"
    render :json => stories
  end
  
  def stories
    source = Source.find(:first,:conditions => ["name LIKE ? AND place IS NOT NULL AND count > 3",params[:source]+"%"])
    stories = Story.find_all_by_source_id(source.id)
    stories.each do |story|
      if source.lat != 0 && source.lon != 0
        story['lon'] = source.lon
        story['lat'] = source.lat
        story['source'] = source.name
        story['location'] = source.place
      end
      ## must store referenced places with has_many
    end
    render :json => stories
  end

  def topic
    sources = []
    Googlenews.topic(params[:topic],20).each do |report|
      name = report['title'].match(/ - ([\w. ]+)/)[1]
      source = Source.find_by_name(name)
      if source
        if source.lat != 0 && source.lon != 0
          report['lon'] = source.lon
          report['lat'] = source.lat
          report['source'] = source.name
          report['location'] = source.place
          # report['destination'] = report.place
          # report['lon_1'] = report.lon
          # report['lat_1'] = report.lat
          sources << report
        end
      else
        source = Source.new({
          :name => name
        })
        source.save
      end
    end
    render :json => sources
  end


  # Use this to find news sources from Google News. 
  # Run it periodically to build up a bank of news sources to include
  def find_sources
    names = ""
    Googlenews.items(100).each do |report|
      name = report['title'].match(/ - ([\w. ]+)/)[1]
      names << name
      unless Source.find_by_name(name)
        source = Source.new({
          :name => name
        })
        source.save
      end
    end
    render :text => names
  end
  
  def locate_sources
    if params[:place]
      geo = GeoKit::GeoLoc.geocode(params[:place])
      if geo
        source = Source.find_by_name(params[:name])
        Source.update(source.id,{
          :name => params[:name],
          :place => params[:place],
          :lat => geo.lat,
          :lon => geo.lng
        })
        source.save
      else
        render :text => "Couldn't geocode that!"
      end
    end
    @blank_sources = Source.find :all, :conditions => {:place => ''}, :order => "id DESC"
    if !@blank_sources
      render :text => "All geocoded."
    end
  end
  

end
