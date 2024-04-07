Rails.application.routes.draw do
  get '/calendar', to: 'calendar#index'
  get 'static_pages/home'
  resources :events
  resources :components
  resources :quests
  resources :workers
  resources :blueprints
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "static_pages#home"
end
