Rails.application.routes.draw do
  get 'messages/show'
  get 'messagerooms/index'
  root :to => 'home_pages#home'
  get 'mypage', to: 'home_pages#mypage'
  get 'requests/index'
  get 'requests/show'
  post 'save_current_location', to: 'requests#save_current_location', as: :save_current_location
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :login
    post 'login', to: 'devise/sessions#create', as: :new_login
    delete 'signout', to: 'devise/sessions#destroy', as: :logout
  end
  
  resources :requests, only: [:index, :create, :show, :destroy] do
    resources :messagerooms, only: [:index, :create, :show]  do
      resources :messages, only: [:create]
    end
  end
end
