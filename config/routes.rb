Rails.application.routes.draw do
  root :to => 'home_pages#home'
  get 'mypage', to: 'home_pages#mypage'
  get 'requests/index'
  get 'requests/show'
  get 'request/search', to: 'requests#nearusers', as: :nearusers_search
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :login
    post 'login', to: 'devise/sessions#create', as: :new_login
    delete 'signout', to: 'devise/sessions#destroy', as: :logout
  end
  
  resources :requests, only: [:index, :create, :show, :destroy]
end
