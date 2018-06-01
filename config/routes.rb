Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'games/who_am_i'
  get 'games/teletype'

  get 'cards/generate'
  get 'cards/generated'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users

  get 'celebrities/random'

  # TODO: think up better routing and controller solution for these has_many :through models
  get '/celebrities/:id/answers', to: 'celebrities#answers'
  get '/celebrities/:id/cards', to: 'celebrities#cards'

  # get 'decks/show'
  resources :decks, only: [:show] do
    member do
      get :sorting_game
    end
  end

  # TODO: might want to nest cards within decks
  resources :cards, only: [:show]
  get '/test', to: 'cards#test'

  get '/cards', to: 'decks#featured'
  get '/signup', to: 'users#new'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/random', to: 'cards#random'
end
