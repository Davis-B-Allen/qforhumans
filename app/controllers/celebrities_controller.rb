class CelebritiesController < ApplicationController
  def random
    @celebrities = Celebrity.all
  end

  # This could conceivably be moved to an answers controller
  def answers
    @celebrity = Celebrity.find(params[:id])
    @answers = @celebrity.answers
    render json: @answers
  end

  # TODO: Unclear which controller this controller action should go in.
  def cards
    @celebrity = Celebrity.find(params[:id])
    @cards = @celebrity.cards
    render json: @cards
  end
end
