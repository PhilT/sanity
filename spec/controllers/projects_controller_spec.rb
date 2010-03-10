require 'spec_helper'

describe ProjectsController do
  describe 'index' do
    it 'should assign projects' do
      mock_project = mock_model(Project)
      Project.stub!(:find).with(:all).and_return([mock_project])
      get :index
      assigns[:projects].should include mock_project
    end
  end

  describe 'show' do
    it 'should assign project' do
      builds = [mock_model(Build)]
      mock_project = mock_model(Project)
      mock_project.stub!(:builds).and_return(builds)
      Project.stub!(:find).with(mock_project.id.to_s).and_return(mock_project)
      get :show, :id => mock_project.id
      assigns[:project].should == mock_project
      assigns[:builds].should == builds
    end

    it 'should do something when project not found' do
      Project.stub!(:find).with('1').and_return(nil)
      get :show, :id => 1
      response.should be_redirect
    end
  end

  describe 'new' do
  end

  describe 'edit' do
  end

  describe 'create' do
  end

  describe 'update' do
  end

end

