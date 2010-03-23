class LinkedinConnection
    
  def self.load
    # return @client if @client
    
    @client = LinkedIn::Client.new('oK0rNTxT4ABjyvGYHTT2Jcb__NiQfd09RWXkmy0a66_gLhLumcpl4YUa0jy-oJap', 'k3GoX6PHqZ_2MueAApZ-K7ZqpdJwTsggVqqInNetDSjj5dFfmUvngMieOOnpSlbx')
    # rtoken = client.request_token.token
    # rsecret = client.request_token.secret
    # to test from your desktop, open the following url in your browser
    # and record the pin it gives you
    # client.request_token.authorize_url
    # => "https://api.linkedin.com/uas/oauth/authorize?oauth_token=<generated_token>"
    # pin = 88405
    # auth = client.authorize_from_request(rtoken, rsecret, pin)
    # 
    # ["ca06763b-9a12-4b40-b5e6-24455d49e912", "59f9be49-81d1-4bfd-b0f7-e188a7d17b5e"]
    
    
    @client.authorize_from_access("ca06763b-9a12-4b40-b5e6-24455d49e912", "59f9be49-81d1-4bfd-b0f7-e188a7d17b5e")
    
    @client
  end
  
  def self.method_missing(method)
    self.load.send(method)
  end
  
end