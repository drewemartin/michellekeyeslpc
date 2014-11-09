Rails.application.routes.draw do
  
  root :to => "homes#index"

  resources :abouts, :path => "about"

  resources :therapys, :path => "therapy"

  resources :homes, :path => "home"

  resources :letters, :path => "contact"


end
