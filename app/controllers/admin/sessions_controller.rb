module Admin
  class SessionsController < ApplicationController
    layout "admin"

    def new
    end

    def create
      if params[:password] == ENV["ADMIN_PASSWORD"]
        session[:admin] = true
        redirect_to admin_root_path
      else
        flash.now[:alert] = "Invalid password"
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete(:admin)
      redirect_to root_path
    end
  end
end
