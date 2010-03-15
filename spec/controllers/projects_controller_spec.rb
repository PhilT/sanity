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

  describe 'new' do
    it 'should assign new project' do
      mock_project = mock_model(Project)
      Project.stub!(:new).and_return(mock_project)
      get :new
      assigns[:project].should == mock_project
    end
  end

  describe 'edit' do
    it 'should assign project' do
      mock_project = mock_model(Project)
      Project.stub!(:find).with(mock_project.id.to_s).and_return(mock_project)
      get :edit, :id => mock_project.id
      assigns[:project].should == mock_project
    end
  end

  describe 'create' do
    before(:each) do
      @mock_project = mock_model(Project)
      @mock_project.stub!(:attributes=)
      Project.stub!(:new).and_return(@mock_project)
    end

    it 'should create project with valid params' do
      @mock_project.stub!(:save).and_return(true)
      @mock_project.should_receive(:prepare)
      post :create, :project => {}
      response.should redirect_to(projects_path)
    end

    it 'should not create project with invalid params' do
      @mock_project.stub!(:save).and_return(false)
      post :create, :project => {}
      response.should render_template(:new)
    end
  end

  describe 'update' do
    before(:each) do
      @mock_project = mock_model(Project)
      @mock_project.stub!(:attributes=)
      Project.stub!(:find).and_return(@mock_project)
    end

    it 'should update project with valid params' do
      @mock_project.stub!(:save).and_return(true)
      @mock_project.should_receive(:prepare)
      post :update, :project => {}, :id => @mock_project.id
      response.should redirect_to(projects_path)
    end

    it 'should not update project with invalid params' do
      @mock_project.stub!(:save).and_return(false)
      post :update, :project => {}, :id => @mock_project.id
      response.should render_template(:edit)
    end
  end

end

