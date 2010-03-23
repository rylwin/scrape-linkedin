class LinkedinScraper
  
  COMPANIES = ['Bain & Company', 'McKinsey & Company', 'Boston Consulting Group']
  SCHOOLS = ['Harvard', 'Stanford', 'Princeton']
  
  def self.scrape_people
    # Linkedin.login
    COMPANIES.each do |company|
      SCHOOLS.each do |school|
        file = File.new(firm_filename(company, school), 'w+')
        xml = Linkedin.advanced_search(:company => company, :current_company => 'Past', :school => school)
        file.write xml
        file.close
      end
    end
  end
  
  def self.store_people
    COMPANIES.each_with_index do |company, i|
      SCHOOLS.each do |school|
        filename = firm_filename(company, school)
        doc = Hpricot.parse(File.read(filename))
        (doc/:person).each do |xml_person|
          person = Person.new(:first_name => (xml_person/"first_name").innerHTML, 
            :last_name => (xml_person/"second_name").innerHTML, 
            :profile_url => (xml_person/"profile"/"url").innerHTML,
            :consulting_firm => Person::CONSULTING_FIRM[i],
            :current_job => parse_jobs((xml_person/"jobs"/"current").innerHTML), 
            :past_jobs => parse_jobs((xml_person/"jobs"/"past").innerHTML),
            :school => school)
          person.truncate_profile_url
          puts "Saving: #{person}"
          person.save!
        end
      end
    end
  end
  
  def self.scrape_profiles
    Person.all.each do |person|
      self.scrape_profile(person)
    end
  end
  
  def self.scrape_profile(person)
    file = File.new(profile_filename(person), 'w+')
    xml = Linkedin.jobs(person)
    file.write xml
    file.close
  end
  
  def self.profile_filename(person)
    File.join('lib', 'scrapes', 'profile', person.profile_key + ".xml")
  end
  
  def self.firm_filename(company, school = nil)
    filename = "#{company.split[0].downcase}_"
    filename += "#{school.split[0].downcase}_" unless school.blank?
    filename += "people.xml"
    File.join('lib', 'scrapes', 'firms', filename)
  end
  
  def self.parse_jobs(jobs)
    return jobs unless jobs.present? and jobs.match(/more\.\.\./)
    # remove new line chars, then get and strip the string between 'more...' and 'less...'
    jobs.gsub("\n",'').match(/more\.\.\.(.*)less\.\.\./)[1].strip
  end
  
end