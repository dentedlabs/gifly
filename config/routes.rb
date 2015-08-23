Rails.application.routes.draw do

  resources :seeding, only: [:create]

  resources :gifs, only: [:index, :show]

end
