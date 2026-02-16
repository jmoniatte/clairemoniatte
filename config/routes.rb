Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#show", defaults: { slug: "home" }

  get "projects" => "projects#index", as: :projects
  get "projects/:id" => "projects#show", as: :project, constraints: { id: /[^\/]+/ }

  get  "admin/login"  => "admin/sessions#new", as: :admin_login
  post "admin/login"  => "admin/sessions#create"
  get  "admin/logout" => "admin/sessions#destroy", as: :admin_logout

  namespace :admin do
    root "dashboard#index"
    resources :pages, only: [:index, :edit, :update]
    resources :projects, except: [:show]
  end

  match "/404", to: "errors#not_found", via: :all

  get ":slug" => "pages#show", as: :page
end
