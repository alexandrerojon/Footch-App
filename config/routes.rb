Rails.application.routes.draw do
  get 'party_ingredients/new'
  get 'party_ingredients/create'
  devise_for :users
  root to: 'user_queries#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :user_queries, only: [ :new, :create, :show, :index ]

  resources :recipes, only: [ :show ] do
    resources :cookbooks, only: [ :create ]
  end
  resources :cookbooks, only: [ :index, :destroy ]
  resources :parties, only: [:index, :new, :create, :show, :destroy] do
    resources :user_parties, only: [:create]
    resources :party_recipes, only: [ :create, :update]
  end

  resources :user_parties, only: [] do
    resources :party_ingredients, only: [:new, :create]
  end
  resources :party_ingredients, only: [:destroy]
end
