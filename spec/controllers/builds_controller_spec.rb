require 'spec_helper'

describe BuildsController do
  describe 'index' do
    it 'should assign project and builds' do
      mock_build = mock_model(Build)
      mock_project = mock_model(Project, :builds => mock('builds', :all => [mock_build]))
      Project.stub!(:find).with('1').and_return(mock_project)
      get :index, :project_id => 1
      assigns[:project].should == mock_project
      assigns[:builds].should include mock_build
    end
  end
end

