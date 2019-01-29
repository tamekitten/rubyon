Rails.application.routes.draw do
  resources :users
  resources :posts
  root 'home#index'

  get 'about_me', to: 'home#about_me'
  get '/home/(:hello)', to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
