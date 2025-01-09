Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :registry_hosts do
    collection do
      get 'list_all'
      get 'search'
    end
    member do
      post 'update_status'
    end
  end
end
