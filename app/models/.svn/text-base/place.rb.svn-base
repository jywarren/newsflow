class Place < ActiveRecord::Base
  validates_uniqueness_of :name
  acts_as_mappable :default_units => :miles, 
                     # :default_formula => :sphere, 
                     # :distance_field_name => :distance,
                     :lat_column_name => :lat,
                     :lng_column_name => :lon
end
