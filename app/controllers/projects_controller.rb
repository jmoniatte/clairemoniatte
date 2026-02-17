class ProjectsController < ApplicationController
  def index
    @projects = Project.published.order(project_date: :desc)
  end

  def show
    @project = Project.published.find_by!(slug: params[:id])
  end
end
