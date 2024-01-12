Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "custom_devise_controllers/sessions" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :groups do
    resources :routines do
      post 'add_exercise/:exercise_id', to: 'routines#add_exercise', as: 'add_exercise'
      resources :exercises
      resources :routine_exercises
      patch 'update_exercises', on: :member
    end
  end
  resources :categories
  root "groups#index"
end
