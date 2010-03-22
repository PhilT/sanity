Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

module Spec::Rails::Example
  class IntegrationExampleGroup < ActionController::IntegrationTest

   def initialize(defined_description, options={}, &implementation)
     defined_description.instance_eval do
       def to_s
         self
       end
     end

     super(defined_description)
   end

    Spec::Example::ExampleGroupFactory.register(:integration, self)
  end
end

