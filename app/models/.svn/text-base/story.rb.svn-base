class Story < ActiveRecord::Base
  belongs_to :source
  validates_uniqueness_of :title
  
  def after_save
    Source.find(self.source_id).tally
  end
  
end
