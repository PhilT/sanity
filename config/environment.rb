RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "sqlite3-ruby", :lib => "sqlite3"
  config.gem 'haml'
  config.gem 'rcov'

  config.time_zone = 'UTC'
end

Sass::Plugin.options[:template_location] = RAILS_ROOT + '/app/styles' if defined?(Sass)

