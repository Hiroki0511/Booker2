Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'users#index'

  resources :users, only: [:index, :edit, :update, :show]
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
end
