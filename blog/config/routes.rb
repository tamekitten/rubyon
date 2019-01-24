Rails.application.routes.draw do
  root 'home#index'

  get 'about_me', to: 'home#about_me'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
