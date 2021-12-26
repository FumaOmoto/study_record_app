Rails.application.routes.draw do  
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"

  get "/signup", to: "users#new"

  resources :users, :except => :new  

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :posts do
    resources :comments, :only =>[:create, :destroy]
  end
  get "/search", to: "posts#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
