Rails.application.routes.draw do

  resources :gifs, only: [:index, :show] do
    get :search, on: :collection
  end
  resources :search, only: [:index]

end
