class DecksController < ApplicationController

  def show
    @deck = Deck.find(params[:id])
  end

  def featured
    @deck = Deck.featured
    render 'show'
  end

  def sorting_game
    @deck = Deck.find(params[:id])
  end
end
