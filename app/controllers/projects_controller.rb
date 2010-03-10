class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    if @project.nil?
      flash[:error] = 'Project not found'
      redirect_to projects_url
    else
      @builds = @project.builds if @project
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    Project.create(params[:project])
    redirect_to project_path(project)
  end

  def update
    project = Project.find(params[:id])
    project.update_attributes(params[:project])
    redirect_to project_path(project)
  end
end

