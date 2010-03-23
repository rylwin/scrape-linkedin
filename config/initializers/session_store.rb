# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_scrape_linkedin_session',
  :secret      => 'd3fd9b4a68f9346338ee0b8b8ace02971b270e3fa16d3664943e6d48f2192812458b2302ae8d32048974a41761cfd3a1b05cfda320fc221b6db81757bb3f9813'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
