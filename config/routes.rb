Vendasml::Application.routes.draw do
  get "sessions/new"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :messages
  resources :sales
  resources :buyers
  resources :users
  resources :sessions

  root :to => "buyers#index"

end
