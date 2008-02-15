class Site < ActiveRecord::Base
  validates_format_of :url, :with => /^\w+\.[a-z0-9.:]+$/i
  def self.find_active
    find(:all, :conditions => 'hits > 0', :order => 'hits desc')
  end
end
