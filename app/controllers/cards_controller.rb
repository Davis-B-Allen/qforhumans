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

  def generator
  end

  def generated
    white_cards = params["whitecards"]
    card_size   = params["cardsize"]
    page_layout = params["pagelayout"]
    dpi = params["dpi"].to_i
    email = params["email"]
    background_color = params["background_color"]
    text_color = params["text_color"]
    bleed = params["bleed"]
    background_color = "ffffff" unless background_color.length == 6 and !background_color[/\H/]
    text_color = "000000" unless text_color.length == 6 and !text_color[/\H/]
    pdf = CardPdf.new(white_cards, card_size, page_layout, background_color, text_color, bleed)
    respond_to do |format|
      format.html do
        pdf_file = Rails.root.join('tmp/cards.pdf')
        pdf.render_file pdf_file
        # instead of doing this now, create a job
        # zipfile_name = PdfConverter.create_images pdf_file, dpi, email
        # File.delete(pdf_file) if File.exist?(pdf_file)
        # send_file zipfile_name
        GenerateAndSendPngsJob.perform_later(pdf_file.to_s, dpi, email)
        flash[:success] = "Your generated images will be emailed to the address you provided"
        redirect_to '/cards/generator'
      end
      format.pdf do
        send_data pdf.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end
end
