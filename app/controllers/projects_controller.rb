class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.js {render :action => :index, :layout => false}
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    save_or_render :new
  end

  def update
    @project = Project.find(params[:id])
    save_or_render :edit
  end

  def save_or_render(template)
    @project.attributes = params[:project]
    if @project.save
      redirect_to projects_path
    else
      render :action => template
    end
  end
end

