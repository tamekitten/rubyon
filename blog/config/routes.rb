Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope "(:locale)", locale:/#{I18n.available_locales.join("|")}/ do
    devise_for :users, path: 'devise', skip: :omniauth_callbacks, controllers: { registrations: 'registrations'}

    resources :users
    resources :posts
    root 'home#index'

    get 'about_me', to: 'home#about_me'
    get '/home/(:hello)', to: 'home#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
