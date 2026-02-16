class ProjectsController < ApplicationController
  def index
    @projects = Project.order(project_date: :desc)
  end

  def show
    @project = Project.find_by!(slug: params[:id])
  end
end
