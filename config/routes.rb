Rails.application.routes.draw do
  get 'games/who_am_i'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users

  get 'celebrities/random'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'decks/show'
  resources :decks, only: [:show] do
    member do
      get :sorting_game
    end
  end
  resources :cards, only: [:show]
  get '/test', to: 'cards#test'

  get '/cards', to: 'decks#featured'
  get '/signup', to: 'users#new'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/random', to: 'cards#random'
end
