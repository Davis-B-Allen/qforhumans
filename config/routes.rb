Rails.application.routes.draw do
  # get 'decks/show'
  resources :decks, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/cards', to: 'static_pages#cards'
  get '/about', to: 'static_pages#about'
end
