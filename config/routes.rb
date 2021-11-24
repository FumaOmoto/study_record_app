Rails.application.routes.draw do
  get "sessions/new"
  get "users/new"
  # ルート
  root "static_pages#home"

  # StaticPages
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"

  # sign in, sign up
  get "/signup", to: "users#new"

  # Users リソース
  resources :users

  # Sessions リソース
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/login", to: "sessions#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
