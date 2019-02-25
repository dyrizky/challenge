Rails.application.routes.draw do
  
  devise_for :users, only: [:sessions]
  root to: 'pages#welcome'
  
  # get 'pages/welcome'
  # get 'pages/yeah'
  namespace :api, :defaults => { :format => 'json' } do
    namespace :admin do
      as :user do
        delete 'sign_out', to: '/devise/sessions#destroy'
      end
      resources :pages, only: :index
    end
  end
  get '/admin', to: 'admin#index'
  match "/admin/*path", to: "admin#index", format: false, via: :get
  root :to => "application#index"
  match "*path", to: "admin#index", format: false, via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
