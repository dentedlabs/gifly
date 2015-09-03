Rails.application.routes.draw do

  resources :gifs, only: [:index, :show]
  resources :oauth, only: [] do
    member do
      get :callback
    end
  end

  resources :search, only: [:index]

end
