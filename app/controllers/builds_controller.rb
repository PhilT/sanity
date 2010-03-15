class BuildsController < ApplicationController
  before_filter :find_project

  def index
    @builds = @project.builds
    respond_to do |format|
      format.html
      format.js {render :action => :index, :layout => false}
    end
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  end
end

