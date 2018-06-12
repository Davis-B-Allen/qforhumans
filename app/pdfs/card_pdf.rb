class CardPdf
  include Prawn::View
  require "prawn/measurement_extensions"

  MM_PER_INCH=25.4

  PAPER_NAME   = "LETTER"
  PAPER_HEIGHT = (MM_PER_INCH*11.0).mm;
  PAPER_WIDTH  = (MM_PER_INCH*8.5).mm;

  BLEED_MARGIN = (MM_PER_INCH*0.25).mm

  LETTER_HEIGHT = (MM_PER_INCH*11.0).mm;
  LETTER_WIDTH  = (MM_PER_INCH*8.5).mm;

  A4_HEIGHT = (297.0).mm;
  A4_WIDTH  = (210.0).mm;

  def initialize(white_cards, card_size, page_layout, background_color, text_color, bleed)
    @white_cards = white_cards
    @card_size   = card_size
    @page_layout = page_layout
    @background_color = background_color
    @text_color = text_color
    @bleed = (bleed == "true")
    # @icon = "default.png"
    @icon = Rails.root.join('app','assets','images','icon.png').to_s
    @one_per_page    = @page_layout == "oneperpage" ? true : false
    @rounded_corners = @card_size   == "LR"         ? true : false
    @card_geometry   = @card_size   == "S" ? get_card_geometry(2.0,2.0,@rounded_corners,@one_per_page) : get_card_geometry(2.5,3.5,@rounded_corners,@one_per_page)

    content()
  end

  def document
    @my_prawn_doc ||= Prawn::Document.new(
      page_size: [@card_geometry["paper_width"], @card_geometry["paper_height"]],
        left_margin: @card_geometry["margin_left"],
        right_margin: @card_geometry["margin_left"],
        top_margin: @card_geometry["margin_top"],
        bottom_margin: @card_geometry["margin_top"],
        info: { :Title => "Cards Against Inanity", :CreationDate => Time.now, :Producer => "Cards Against Inanity", :Creator=>"Cards Against Inanity" }
    )
  end

  def get_card_geometry(card_width_inches=2.0, card_height_inches=2.0, rounded_corners=false, one_card_per_page=false)
  	card_geometry = Hash.new
  	card_geometry["card_width"]        = (MM_PER_INCH*card_width_inches).mm
  	card_geometry["card_height"]       = (MM_PER_INCH*card_height_inches).mm

  	card_geometry["rounded_corners"]   = rounded_corners == true ? ((1.0/8.0)*MM_PER_INCH).mm : rounded_corners
  	card_geometry["one_card_per_page"] = one_card_per_page

  	if card_geometry["one_card_per_page"]
  		card_geometry["paper_width"]       = card_geometry["card_width"] + (@bleed ? BLEED_MARGIN : 0.0)
  		card_geometry["paper_height"]      = card_geometry["card_height"] + (@bleed ? BLEED_MARGIN : 0.0)
  	else
  		card_geometry["paper_width"]       = PAPER_WIDTH
  		card_geometry["paper_height"]      = PAPER_HEIGHT
  	end


  	card_geometry["cards_across"] = (card_geometry["paper_width"] / card_geometry["card_width"]).floor
  	card_geometry["cards_high"]   = (card_geometry["paper_height"] / card_geometry["card_height"]).floor

  	card_geometry["page_width"]   = card_geometry["card_width"] * card_geometry["cards_across"]
  	card_geometry["page_height"]  = card_geometry["card_height"] * card_geometry["cards_high"]

  	card_geometry["margin_left"]  = (card_geometry["paper_width"] - card_geometry["page_width"] ) / 2
  	card_geometry["margin_top"]   = (card_geometry["paper_height"] - card_geometry["page_height"] ) / 2

  	return card_geometry;
  end

  def draw_grid(card_geometry)
    unless (@bleed && @one_per_page)
      stroke do
    		if card_geometry["rounded_corners"] == false
    			#Draw vertical lines
    			0.upto(card_geometry["cards_across"]) do |i|
    				line(
    					[card_geometry["card_width"]*i, 0],
    					[card_geometry["card_width"]*i, card_geometry["page_height"]]
    					)
    			end

    			#Draw horizontal lines
    			0.upto(card_geometry["cards_high"]) do |i|
    				line(
    					[0,                           card_geometry["card_height"]*i],
    					[card_geometry["page_width"], card_geometry["card_height"]*i]
    					)

    			end
    		else
    			0.upto(card_geometry["cards_across"]-1) do |i|
    				0.upto(card_geometry["cards_high"]-1) do |j|
    					#rectangle bounded by upper left corner, horizontal measured from the left, vertical measured from the bottom
    					rounded_rectangle(
    								[i*card_geometry["card_width"], card_geometry["card_height"]+(j*card_geometry["card_height"])],
    								card_geometry["card_width"],
    								card_geometry["card_height"],
    								card_geometry["rounded_corners"]
    								)
    				end
    			end
    		end
    	end
    end
  end

  def box(card_geometry, index, &blck)
  	# Determine row + column number
  	column = index%card_geometry["cards_across"]
  	row = card_geometry["cards_high"] - index/card_geometry["cards_across"]

  	# Margin: 10pt
  	x = card_geometry["card_width"] * column + 10
  	y = card_geometry["card_height"] * row - 10

  	bounding_box([x,y], width: card_geometry["card_width"]-20, height: card_geometry["card_height"]-10, &blck)
  end

  def draw_logos(card_geometry, icon)
  	idx=0
  	while idx < card_geometry["cards_across"] * card_geometry["cards_high"]
  		box(card_geometry, idx) do
  			logo_max_height = 15
  			logo_max_width = card_geometry["card_width"]/2
  			image icon, fit: [logo_max_width,logo_max_height], at: [bounds.left,bounds.bottom+25]
  			font "Helvetica", :style => :normal
  			text_box "Cards Against Inanity", size:8, align: :left, width:100, at: [bounds.left+20,bounds.bottom+20]
  		end
  		idx = idx + 1
  	end
  end

  def render_card_page(card_geometry, icon, statements, background_color, text_color)
  	font "Helvetica", :style => :normal
  	font_size 14
  	line_width(0.5);

    canvas do
      rectangle(bounds.top_left,bounds.width, bounds.height)
    end
    stroke_color background_color
    fill_color background_color
    fill { rectangle(bounds.top_left,bounds.width, bounds.height) }
    stroke_color text_color
    fill_color text_color

  	draw_grid(card_geometry)
  	statements.each_with_index do |line, idx|
  		box(card_geometry, idx) do

  			line_parts = line.split(/\t/)
  			card_text = line_parts.shift
  			card_text = card_text.gsub(/\\n */, "\n")
  			card_text = card_text.gsub(/\\t/,   "\t")

  			card_text = card_text.gsub("<b>", "[[[b]]]")
  			card_text = card_text.gsub("<i>", "[[[i]]]")
  			card_text = card_text.gsub("<u>", "[[[u]]]")
  			card_text = card_text.gsub("<strikethrough>", "[[[strikethrough]]]")
  			card_text = card_text.gsub("<sub>", "[[[sub]]]")
  			card_text = card_text.gsub("<sup>", "[[[sup]]]")
  			card_text = card_text.gsub("<font", "[[[font")
  			card_text = card_text.gsub("<color", "[[[color")
  			card_text = card_text.gsub("<br>", "[[[br/]]]")
  			card_text = card_text.gsub("<br/>", "[[[br/]]]")
  			card_text = card_text.gsub("<br />", "[[[br/]]]")

  			card_text = card_text.gsub("</b>", "[[[/b]]]")
  			card_text = card_text.gsub("</i>", "[[[/i]]]")
  			card_text = card_text.gsub("</u>", "[[[/u]]]")
  			card_text = card_text.gsub("</strikethrough>", "[[[/strikethrough]]]")
  			card_text = card_text.gsub("</sub>", "[[[/sub]]]")
  			card_text = card_text.gsub("</sup>", "[[[/sup]]]")
  			card_text = card_text.gsub("</font>", "[[[/font]]]")
  			card_text = card_text.gsub("</color>", "[[[/color]]]")

  			card_text = card_text.gsub(/</, "&lt;");

  			card_text = card_text.gsub("\[\[\[b\]\]\]", "<b>")
  			card_text = card_text.gsub("\[\[\[i\]\]\]", "<i>")
  			card_text = card_text.gsub("\[\[\[u\]\]\]", "<u>")
  			card_text = card_text.gsub("\[\[\[strikethrough\]\]\]", "<strikethrough>")
  			card_text = card_text.gsub("\[\[\[sub\]\]\]", "<sub>")
  			card_text = card_text.gsub("\[\[\[sup\]\]\]", "<sup>")
  			card_text = card_text.gsub("\[\[\[font", "<font")
  			card_text = card_text.gsub("\[\[\[color", "<color")
  			card_text = card_text.gsub("\[\[\[br/\]\]\]", "<br/>")

  			card_text = card_text.gsub("\[\[\[/b\]\]\]", "</b>")
  			card_text = card_text.gsub("\[\[\[/i\]\]\]", "</i>")
  			card_text = card_text.gsub("\[\[\[/u\]\]\]", "</u>")
  			card_text = card_text.gsub("\[\[\[/strikethrough\]\]\]", "</strikethrough>")
  			card_text = card_text.gsub("\[\[\[/sub\]\]\]", "</sub>")
  			card_text = card_text.gsub("\[\[\[/sup\]\]\]", "</sup>")
  			card_text = card_text.gsub("\[\[\[/font\]\]\]", "</font>")
  			card_text = card_text.gsub("\[\[\[/color\]\]\]", "</color>")

  			# Check for category to include
  			# surrounded by $$ - e.g. $$Category$$
  			category = card_text.scan(/\$\$([^\$]*)\$\$/).last
  			if not category.nil?
  			  category = category.first
  			end
  			card_text = card_text.gsub(/\$\$([^\$]*)\$\$/, "").strip

  			parts = card_text.split(/\[\[/)
  			card_text = ""
  			first = true
  			previous_matches = false
  			parts.each do |p|
  				n = p
  				this_matches=false
  				if p.match(/\]\]/)
  					s = p.split(/\]\]/)
  					line_parts.push(s[0])
  					if s.length > 1
  						n = s[1]
  					else
  						n = ""
  					end
  					this_matches=true
  				end

  				if first
  					card_text = n.to_s
  				elsif this_matches
  					card_text = card_text + n
  				else
  					card_text = card_text + "[[" + n
  				end
  				first = false
  			end
  			card_text = card_text.gsub(/^[\t ]*/, "")
  			card_text = card_text.gsub(/[\t ]*$/, "")

  			is_pick2 = false
  			is_pick3 = false

  			picknum = "0"
  			if is_pick2
  				picknum = "2"
  			elsif is_pick3
  				picknum = "3"
  			end

  			statements[idx] = [card_text,picknum]

  			#by default cards should be bold
  			card_text = "<b>" + card_text + "</b>"

        # font "Helvetica", :style => :bold
        font "Helvetica", :style => :normal
        # font "noto", :style => :normal
        # font "segoe"

  			if is_pick3
          # text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-55, :inline_format => true
          # text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-55
  				text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-55, :fallback_fonts => ["noto"], :inline_format => true
          # text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-55, :fallback_fonts => ["noto"]
  			else
          # text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-35, :inline_format => true
          # text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-35
  				text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-35, :fallback_fonts => ["noto"], :inline_format => true
          # text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-35, :fallback_fonts => ["noto"]
  			end

  			if not category.nil?
  				bounding_box([bounds.right-60, bounds.bottom+20], :width => 60, :height => 20) do
  					text category, size:8, align: :right
  				end
  			end
  		end
  	end
  	draw_logos(card_geometry, icon)
  	stroke_color "000000"
  	fill_color "000000"
  end

  def load_pages_from_lines(lines, card_geometry)
  	pages = []

  	non_empty_lines = []
  	lines.each do |line|
  		line = line.gsub(/^[\t\n\r]*/, "")
  		line = line.gsub(/[\t\n\r]*$/, "")
  		if line != ""
  			non_empty_lines.push(line)
  		end
  	end
  	lines = non_empty_lines

  	cards_per_page = card_geometry["cards_high"] * card_geometry["cards_across"]
  	num_pages = (lines.length.to_f/cards_per_page.to_f).ceil

  	0.upto(num_pages - 1) do |pn|
   		pages << lines[pn*cards_per_page,cards_per_page]
    end

  	return pages
  end

  def load_pages_from_string(string, card_geometry)
  	lines = string.split(/[\r\n]+/)
  	pages = load_pages_from_lines(lines, card_geometry)
  	return pages
  end

  # render_cards nil, nil, nil, icon, "cards.pdf", true, false, false, card_geometry, white_cards, black_cards, true
  def render_cards(icon_file="icon.png", card_geometry=get_card_geometry, white_string="", background_color = "ffffff", text_color = "000000")

  	white_pages = []
  	if white_string == ""
  		white_string = " "
  	end
		white_pages = load_pages_from_string(white_string, card_geometry)

    font_families.update(
      "segoe" => {
        :normal => Rails.root.join('app','assets','fonts','SEGOEPR.TTF').to_s,
        :bold => Rails.root.join('app','assets','fonts','SEGOEPRB.TTF').to_s
      }
    )

    font_families.update(
      "noto" => {
        :normal => Rails.root.join('app','assets','fonts','NotoSans-Regular.ttf').to_s,
        :italic => Rails.root.join('app','assets','fonts','NotoSans-Italic.ttf').to_s,
        :bold => Rails.root.join('app','assets','fonts','NotoSans-Bold.ttf').to_s,
        :bold_italic => Rails.root.join('app','assets','fonts','NotoSans-BoldItalic.ttf').to_s,
      }
    )

		white_pages.each_with_index do |statements, page|
			render_card_page(card_geometry, icon_file, statements, background_color, text_color)
			start_new_page unless page >= white_pages.length-1
		end
  end

  def content()
    render_cards @icon, @card_geometry, @white_cards, @background_color, @text_color
  end

end
