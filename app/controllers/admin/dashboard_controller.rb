module Admin
  class DashboardController < BaseController
    def index
      @pages = Page.order(:title)
      @projects = Project.order(project_date: :desc)
    end
  end
end
