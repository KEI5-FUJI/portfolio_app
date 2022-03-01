Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    root 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new', as: :login
    post 'login', to: 'devise/sessions#create', as: :new_login
    delete 'signout', to: 'devise/sessions#destroy', as: :logout
  end
end
