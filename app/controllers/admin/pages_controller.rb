module Admin
  class PagesController < BaseController
    def index
      @pages = Page.order(:title)
    end

    def edit
      @page = Page.find(params[:id])
    end

    def update
      @page = Page.find(params[:id])
      if @page.update(page_params)
        redirect_to admin_pages_path, notice: "Page updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def page_params
      params.require(:page).permit(:title, :body)
    end
  end
end
