class Source < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :stories
  
  def tally
    self.count = Story.count(self.id, :conditions => {:source_id => self.id})
    self.save!
  end
  
end
