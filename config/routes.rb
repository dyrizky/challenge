Rails.application.routes.draw do
  
  devise_for :users, only: [:sessions]
  root to: 'admin#index'
  
  # get 'pages/welcome'
  # get 'pages/yeah'
  namespace :api, :defaults => { :format => 'json' } do
    # namespace :admin do
      as :user do
        delete 'sign_out', to: '/devise/sessions#destroy'
      end
      get 'task', to: "task#index"
      put 'task/complate/:id', to: "task#complate"
      get 'task/prev', to: "task#previous"
      post 'task/store', to: "task#store"
    end
  # end
  get '/admin', to: 'admin#index'
  get '/task', to: 'admin#index'
  match "/task/*path", to: "admin#index", format: false, via: :get
  root :to => "application#index"
  # match "*path", to: "admin#index", format: false, via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
