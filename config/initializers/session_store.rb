# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_momentum_session',
  :secret      => '9ec97699653b39d96faa1ded514517392bca29b1294ffe8faf5b95bc3296215de226bcc72697b7e1647b2a51d4097d40df32e54023005e976b8b5c9ad58e28a2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
