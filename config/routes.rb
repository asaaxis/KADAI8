Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
  resources :users

  resources :pictures do
    collection do
      post :confirm
    end
  end
end
