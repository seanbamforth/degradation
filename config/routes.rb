Degradation::Application.routes.draw do
  get "home/index"
  root :to => 'home#index'

  resources :books
  resources :authors
end
