require 'test_helper'

class LinkedinScraperTest < ActiveSupport::TestCase
  
  def setup
    @job1 = "Manager at Bain &amp; Company, Senior Marketing Manager at  more...
Manager at Bain &amp; Company, Senior Marketing Manager at Paramark, Product Marketing Manager at Zembu, Founder and CEO at Collegiate Recruiting Technologies, Research Assistant at Brookings Institution less..."
    @job1_parsed = "Manager at Bain &amp; Company, Senior Marketing Manager at Paramark, Product Marketing Manager at Zembu, Founder and CEO at Collegiate Recruiting Technologies, Research Assistant at Brookings Institution"
    
    @job2 = "SVP &amp; GM, Entertainment &amp; Lifestyle at CBS Interactive"

    @job3 = "Co-founder &amp; CEO at Dotspotter (acquired by CBS), Vice  more...
Co-founder &amp; CEO at Dotspotter (acquired by CBS), Vice President at Yahoo! Inc., Chief Operating Officer at ALWAYSi (acquired by Hollywood Media), Group Manager, Products at Inktomi Corp., Summer Associate at Bain &amp; Company, Product Manager at Apple Computer less..."
    @job3_parsed = "Co-founder &amp; CEO at Dotspotter (acquired by CBS), Vice President at Yahoo! Inc., Chief Operating Officer at ALWAYSi (acquired by Hollywood Media), Group Manager, Products at Inktomi Corp., Summer Associate at Bain &amp; Company, Product Manager at Apple Computer"
    @job4 = "Director at Glenmore Advisors LLC"
  end
  
  # Replace this with your real tests.
  test "parse jobs" do
    assert_equal '', LinkedinScraper.parse_jobs("")
    assert_equal "test", LinkedinScraper.parse_jobs("test")
    assert_equal @job1_parsed, LinkedinScraper.parse_jobs(@job1)
    assert_equal @job2, LinkedinScraper.parse_jobs(@job2)
    assert_equal @job3_parsed, LinkedinScraper.parse_jobs(@job3)
    assert_equal @job4, LinkedinScraper.parse_jobs(@job4)
  end
end
