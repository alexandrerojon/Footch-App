Rails.application.routes.draw do
  devise_for :users
  root to: 'user_queries#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :user_queries, only: [ :new, :create, :show, :index ]

  resources :recipes, only: [ :show ] do
    resources :cookbooks, only: [ :create ]
  end
  resources :cookbooks, only: [ :index, :destroy ]

end
