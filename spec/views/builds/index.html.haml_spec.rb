require 'spec_helper'

describe 'builds/index.html.haml' do

  it 'should be valid XHTML' do
    assigns[:project] = mock_model(Project, :name => 'A Project', :clone_from => 'git clone URL')
    assigns[:builds] = [mock_model(Build, :created_at => Time.now, :updated_at => 'some time ago', :success? => true, :commit_hash => '1234567', :committed_at => 'some time', :branch => 'master', :author => 'me', :commit_message => 'some message', :completed_at => 'some time')]
    render
    response.body.should be_valid_xhtml
  end

end

