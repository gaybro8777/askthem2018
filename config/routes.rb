Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
end
