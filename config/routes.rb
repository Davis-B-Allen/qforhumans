Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'decks/show'
  resources :decks, only: [:show]
  resources :cards, only: [:show]

  get '/cards', to: 'decks#featured'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/random', to: 'cards#random'
end
