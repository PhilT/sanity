require 'spec_helper'

describe 'projects/index.html.haml' do
  include ProjectsHelper

  it do
    assigns[:projects] = [mock_model(Project, :name => 'A Project', :builds => [mock_model(Build, :created_at => Time.now, :success? => true)])]
    render
    response.body.should be_valid_xhtml
  end

end

