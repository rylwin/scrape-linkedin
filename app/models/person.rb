class Person < ActiveRecord::Base
  acts_as_enum :consulting_firm, [:bain, :mckinsey, :bcg]
  acts_as_enum :entrepreneur, [:unknown, :no, :yes, :revisit, :still_consultant_at_firm, :back_to_school, :private_equity, :invalid]
  validates_presence_of :first_name, :profile_url
  
  named_scope :firm, lambda { |firm| { :conditions => {:consulting_firm => CONSULTING_FIRM.index(firm)} } }
  named_scope :category, lambda { |cat| { :conditions => {:entrepreneur => ENTREPRENEUR.index(cat)} } }
  named_scope :after, lambda { |previous| { :conditions => ['id > ?', previous.id] } }
  named_scope :school, lambda { |school| { :conditions => {:school => school} } }
  
  
    
  def to_s
    "#{first_name} #{last_name}"
  end
  
  def truncate_profile_url
    self.profile_url = profile_url.gsub(/\&authToken(.*)/, '')
  end
  
  def profile_key
    profile_url.match(/key=(.*)/)[1]
  end
  
  def self.next_uncategorized(previous=nil)
    if previous.present?
      Person.category(nil).after(previous).first||Person.category(:revisit).after(previous).first
    else
      find_by_entrepreneur(nil)||Person.category(:revisit).first
    end
  end
end
