Rails.application.routes.draw do
    scope ":locale" do 
        get '/calendar', to: 'calendar#index'
        get 'static_pages/home'
        resources :events
        resources :components
        resources :quests
        resources :workers
        resources :blueprints
        root to: "static_pages#home", as: :localized_root #localized_root_path

    end 
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
    root to: redirect("/#{I18n.locale}", status: 302)

end
