class BuildsController < ApplicationController
  before_filter :find_project

  def index
    unless params[:from].blank?
      last_build = @project.builds.find(params[:from])
      conditions = "created_at >= '#{last_build.created_at}'"
    end
    @builds = @project.builds.all(:conditions => conditions)
    respond_to do |format|
      format.html
      format.js {render :partial => 'build', :collection => @builds}
    end
  end

  def show
    build = @project.builds.find(params[:id])
    render :partial => 'build', :object => build
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  end
end

