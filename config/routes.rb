Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :questions, :only => [:index, :new, :create, :show]
  resources :candidates, :only => [:index, :show]
  resources :votes, :only => :create
  get 'search', to: 'search#index', as: :search
end
