class Linkedin
    
  def self.login
    property_data = Scrubyt::Extractor.define :agent => :firefox do
      fetch "https://www.linkedin.com/secure/login"
    
      fill_textfield 'session_key', '********'
      fill_textfield 'session_password', '********'
      submit
    end
  end
  
  def self.search(text)
    property_data = Scrubyt::Extractor.define :agent => :firefox do
      fetch "http://www.linkedin.com/commonSearch?type=people&keywords=#{text}&pplSearchOrigin=GLHD&pageKey=home"
      sleep 2
      
      people "//ol[@class='photos']" do
        person "//li[@class~='vcard']" do
          first_name  "//span[@class='given-name']"
          second_name "//span[@class='family-name']"
          profile "//a[@class~='trk-profile-name']" do
            url "href", :type => :attribute
          end
        end
      end
      
      next_page "//p[@class='page']//a:last-of-type", :limit => 10, :example_type => :xpath
    end
    property_data.to_xml
  end
  
  def self.advanced_search(options)
    property_data = Scrubyt::Extractor.define :agent => :firefox do
      fetch "http://www.linkedin.com/search"
      
      [:company, :school].each do |textfield|
        fill_textfield textfield.to_s, options[textfield] unless options[textfield].blank?
      end
      
      select_option 'currentCompany', options[:current_company] unless options[:current_company].blank?

      # This will result in a search for US only (country defaults to US)
      select_option 'searchLocationType', 'Located in or near:'
      fill_textfield 'postalCode', ''
      
      # Get expanded view, which gives us more job info
      select_option 'viewCriteria', 'Expanded'
      
      submit
      sleep 2
      
      people "//ol[@class='photos']" do
        person "//li[@class~='vcard']" do
          first_name  "//span[@class='given-name']"
          second_name "//span[@class='family-name']"
          title "//dd[@class='title]"
          location "//dl[@class='vcard-basic']//span[@class='location']"
          industry "//dl[@class='vcard-basic']//span[@class='industry']"
          profile "//a[@class~='trk-profile-name']" do
            url "href", :type => :attribute
          end
          # expanded info
          jobs "//dl[@class~='vcard-expanded']" do
            current "//dd[1]"
            past "//dd[2]"
          end
        end
      end
      
      next_page "//p[@class='page']//a:last-of-type", :limit => 10, :example_type => :xpath
    end
    property_data.to_xml
  end
  
  def self.jobs(person)
    property_data = Scrubyt::Extractor.define :agent => :firefox do
      fetch "http://www.linkedin.com#{person.profile_url}"
      
      sleep 1
      
      jobs "//div[@id='profile-experience']" do
        job "//div[@class~='position']" do
          title  "//a[@name='title']"
          company "//h4" #do
            # name "//a[@name~='company']"
            # url "href", :type => :attribute
          # end
          period "//p[@class~='period']" 
          description "//p[@class~='desc']"           
        end
      end
      
    end
    property_data.to_xml
  end
    
end