Rails.application.routes.draw do

  # get 'oauth/authroize'

  resources :gifs, only: [:index, :show]


  resources :oauth, only: [:index, :create] do
    member do
      post :authorize
      get :callback
    end
  end

  resources :search, only: [:index]

end
