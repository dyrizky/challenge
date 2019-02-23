Rails.application.routes.draw do
  
  devise_for :users, only: [:sessions]
  root to: 'pages#welcome'
  
  get 'pages/welcome'
  get 'pages/yeah'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
