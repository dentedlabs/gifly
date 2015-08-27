Rails.application.routes.draw do

  resources :gifs, only: [:index, :show]
  resources :search, only: [:index]

end
