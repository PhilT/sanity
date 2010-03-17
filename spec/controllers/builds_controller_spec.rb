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

    it 'should assign builds from given build' do
      created_at = 'some time'
      mock_build = mock_model(Build, :created_at => created_at)
      mock_association = mock('builds')
      mock_association.should_receive(:find).with('2').and_return(mock_build)
      mock_association.should_receive(:all).with(:conditions => "created_at >= '#{created_at}'")
      Project.stub!(:find => mock_model(Project, :builds => mock_association))

      get :index, :project_id => 1, :from => '2'
    end
  end

  describe 'show' do
    it 'should render a given build' do
      mock_build = mock_model(Build)
      mock_association = mock('builds')
      mock_association.should_receive(:find).with('2').and_return(mock_build)
      Project.stub!(:find => mock_model(Project, :builds => mock_association))

      get :show, :project_id => 1, :id => 2
      response.should render_template('_build')
    end
  end
end

