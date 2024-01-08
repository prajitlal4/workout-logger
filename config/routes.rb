Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "custom_devise_controllers/sessions" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :workspaces
  root "workspaces#index"
end
