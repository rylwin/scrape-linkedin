module PeopleHelper
  
  def link_to_profile(person)
    # including the auth token and type gives slightly more access to profile
    "http://www.linkedin.com#{person.profile_url}&authToken=EOPa&authType=OUT_OF_NETWORK"
  end
  
  def total(firm=nil)
    if firm.present?
      Person.firm(firm).category(:yes).count.to_f+Person.firm(firm).category(:no).count.to_f
    else
      (Person.category(:yes).count+Person.category(:no).count).to_f
    end
  end
  
  def yes_percent(firm)
    Person.firm(firm).category(:yes).count.to_f/(total(firm))
  end
  
  def no_percent(firm)
    Person.firm(firm).category(:no).count.to_f/(total(firm))
  end
  
  def firm_prob(firm)
    total(firm)/total
  end
  
  def entr_prob(firm)
    Person.category(:yes).firm(firm).count/total
  end
  
  def bayes(firm)
    entr_prob(firm)/firm_prob(firm)
  end
  
end
