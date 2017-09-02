class DecksController < ApplicationController

  def featured
    @deck = Deck.find(1)
    render 'show'
  end

  def show
    @deck = Deck.find(params[:id])
  end
end
