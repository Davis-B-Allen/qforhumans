class CardsController < ApplicationController

  def test
    @card = Card.order("RANDOM()").first
    render layout: false
  end

  def show
    @card = Card.find(params[:id])
  end

  # Returns a random card
  # Note that this method uses a database call that is NOT DATABASE AGNOSTIC
  # "RANDOM()" should work for postgresql and sqlite
  # Also note that this returns ANY random card, not just any random card belonging to a given deck
  def random
    @card = Card.order("RANDOM()").first
    # Note: Could alternatively redirect to the card show path for the random card
    render 'show'
  end

  def generate

  end

  def generated
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Hello World!"
        pdf.text params[:q]
        send_data pdf.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end
end
