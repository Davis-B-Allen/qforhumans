class CardPdf
  include Prawn::View
  require "prawn/measurement_extensions"

  MM_PER_INCH=25.4

  PAPER_NAME   = "LETTER"
  PAPER_HEIGHT = (MM_PER_INCH*11.0).mm;
  PAPER_WIDTH  = (MM_PER_INCH*8.5).mm;

  def initialize(params, whitecards, blackcards)
    # content(whitecards, blackcards)
    @white_cards = params["whitecards"]
    @black_cards = params["blackcards"]
    @card_size   = params["cardsize"]
    @page_layout = params["pagelayout"]
    # @icon = "default.png"
    @icon = Rails.root.join('app','assets','images','icon.png').to_s
    @one_per_page    = @page_layout == "oneperpage" ? true : false
    @rounded_corners = @card_size   == "LR"         ? true : false
    @card_geometry   = @card_size   == "S" ? get_card_geometry(2.0,2.0,@rounded_corners,@one_per_page) : get_card_geometry(2.5,3.5,@rounded_corners,@one_per_page)

    content(params)
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

  # def content(whitecards, blackcards)
  #   text "Cards"
  #   text whitecards
  #   text blackcards
  # end

  def get_card_geometry(card_width_inches=2.0, card_height_inches=2.0, rounded_corners=false, one_card_per_page=false)
  	card_geometry = Hash.new
  	card_geometry["card_width"]        = (MM_PER_INCH*card_width_inches).mm
  	card_geometry["card_height"]       = (MM_PER_INCH*card_height_inches).mm

  	card_geometry["rounded_corners"]   = rounded_corners == true ? ((1.0/8.0)*MM_PER_INCH).mm : rounded_corners
  	card_geometry["one_card_per_page"] = one_card_per_page

  	if card_geometry["one_card_per_page"]
  		card_geometry["paper_width"]       = card_geometry["card_width"]
  		card_geometry["paper_height"]      = card_geometry["card_height"]
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

  def render_card_page(card_geometry, icon, statements, is_black)

  	font "Helvetica", :style => :normal
  	font_size = 14
  	line_width(0.5);


  	if(is_black)
  		canvas do
  			rectangle(bounds.top_left,bounds.width, bounds.height)
  		end

  		fill_and_stroke(:fill_color=>"000000", :stroke_color=>"000000") do
  			canvas do
  				rectangle(bounds.top_left,bounds.width, bounds.height)
  			end
  		end
  		stroke_color "ffffff"
  		fill_color "ffffff"
  	else
  		stroke_color "000000"
  		fill_color "000000"
  	end

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
  			if is_black
  				pick_num = line_parts.shift
  				if pick_num.nil? or pick_num == ""
  					tmpline = "a" + card_text.to_s + "a"
  					parts = tmpline.split(/__+/)
  					if parts.length == 3
  						is_pick2 = true
  					elsif parts.length >= 4
  						is_pick3 = true
  					end
  				elsif pick_num == "2"
  					is_pick2 = true
  				elsif pick_num == "3"
  					is_pick3 = true
  				end

  			end


  			picknum = "0"
  			if is_pick2
  				picknum = "2"
  			elsif is_pick3
  				picknum = "3"
  			elsif is_black
  				picknum = "1"
  			end

  			statements[idx] = [card_text,picknum]

  			#by default cards should be bold
  			# card_text = "<b>" + card_text + "</b>"



  			# Text
  			# font "Helvetica", :style => :normal
        font "Helvetica", :style => :bold
        # font "segoe"

  			if is_pick3
  				# text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-55, :inline_format => true
          text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-55
  			else
  				# text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-35, :inline_format => true
          text_box card_text.to_s, :overflow => :shrink_to_fit, :height =>card_geometry["card_height"]-35
  			end

  			if not category.nil?
  				# text_box category, size:11, align: :right, at: [bounds.right-20,bounds.bottom+20]
  				bounding_box([bounds.right-60, bounds.bottom+20], :width => 60, :height => 20) do
  					text category, size:8, align: :right
  				end
  			end

  			# font "Helvetica", :style => :bold
  			# #pick 2
  			# if is_pick2
  			# 	text_box "PICK", size:11, align: :right, width:30, at: [bounds.right-50,bounds.bottom+20]
  			# 	fill_and_stroke(:fill_color=>"ffffff", :stroke_color=>"ffffff") do
  			# 		circle([bounds.right-10,bounds.bottom+15.5],7.5)
  			# 	end
  			# 	stroke_color '000000'
  			# 	fill_color '000000'
  			# 	text_box "2", color:"000000", size:14, width:8, align: :center, at:[bounds.right-14,bounds.bottom+21]
  			# 	stroke_color "ffffff"
  			# 	fill_color "ffffff"
  			# end
  			#
  			# #pick 3
  			# if is_pick3
  			# 	text_box "PICK", size:11, align: :right, width:30, at: [bounds.right-50,bounds.bottom+20]
  			# 	fill_and_stroke(:fill_color=>"ffffff", :stroke_color=>"ffffff") do
  			# 		circle([bounds.right-10,bounds.bottom+15.5],7.5)
  			# 	end
  			# 	stroke_color '000000'
  			# 	fill_color '000000'
  			# 	text_box "3", color:"000000", size:14, width:8, align: :center, at:[bounds.right-14,bounds.bottom+21]
  			# 	stroke_color "ffffff"
  			# 	fill_color "ffffff"
  			#
  			#
  			# 	text_box "DRAW", size:11, align: :right, width:35, at: [bounds.right-55,bounds.bottom+40]
  			# 	fill_and_stroke(:fill_color=>"ffffff", :stroke_color=>"ffffff") do
  			# 		circle([bounds.right-10,bounds.bottom+35.5],7.5)
  			# 	end
  			# 	stroke_color '000000'
  			# 	fill_color '000000'
  			# 	text_box "2", color:"000000", size:14, width:8, align: :center, at:[bounds.right-14,bounds.bottom+41]
  			# 	stroke_color "ffffff"
  			# 	fill_color "ffffff"
  			# end
  		end
  	end
  	draw_logos(card_geometry, icon)
  	stroke_color "000000"
  	fill_color "000000"

  end

  def load_ttf_fonts(font_dir, font_families)

  	if font_dir.nil?
  		return
  	elsif (not Dir.exist?(font_dir)) or (font_families.nil?)
  		return
  	end

  	font_files = Hash.new
  	ttf_files=Dir.glob(font_dir + "/*.ttf")
  	ttf_files.each do |ttf|
  		full_name = ttf.gsub(/^.*\//, "")
  		full_name = full_name.gsub(/\.ttf$/, "")
  		style = "normal"
  		name = full_name
  		if name.match(/_Bold_Italic$/)
  			style = "bold_italic"
  			name = name.gsub(/_Bold_Italic$/, "")
  		elsif name.match(/_Italic$/)
  			style = "italic"
  			name = name.gsub(/_Italic$/, "")
  		elsif name.match(/_Bold$/)
  			style = "bold"
  			name = name.gsub(/_Bold$/, "")
  		end

  		name = name.gsub(/_/, " ");

  		if not (font_files.has_key? name)
  			font_files[name] = Hash.new
  		end
  		font_files[name][style] = ttf
  	end

  	font_files.each_pair do |name, ttf_files|
  		if (ttf_files.has_key? "normal" ) and (not font_families.has_key? "name" )
  			normal = ttf_files["normal"]
  			italic = (ttf_files.has_key? "italic") ?  ttf_files["italic"] : normal
  			bold   = (ttf_files.has_key? "bold"  ) ?  ttf_files["bold"]   : normal
  			bold_italic = normal
  			if ttf_files.has_key? 'bold_italic'
  				bold_italic = ttf_files["bold_italic"]
  			elsif ttf_files.has_key? 'italic'
  				bold_italic = italic
  			elsif ttf_files.has_key? 'bold'
  				bold_italic = bold
  			end


  			font_families.update(name => {
  				:normal => normal,
  				:italic => italic,
  				:bold => bold,
  				:bold_italic => bold_italic
  			})

  		end
  	end
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
  def render_cards(directory=".", white_file="white.txt", black_file="black.txt", icon_file="icon.png", output_file="cards.pdf", input_files_are_absolute=false, output_file_name_from_directory=true, recurse=true, card_geometry=get_card_geometry, white_string="", black_string="", output_to_stdout=false, title=nil )

  	# if not File.exist? icon_file
  	# 	icon_file = "./default.png"
  	# end

  	white_pages = []
  	black_pages = []
  	if white_file == nil and black_file == nil and white_string == "" and black_string == ""
  		white_string = " "
  		black_string = " "
  	end
		white_pages = load_pages_from_string(white_string, card_geometry)
		black_pages = load_pages_from_string(black_string, card_geometry)

		# load_ttf_fonts("/usr/share/fonts/truetype/msttcorefonts", font_families)
		# font_path = Rails.root.join('app','assets','fonts','NotoSans-Regular.ttf').to_s
    # puts font_path
    # font_families.update(
    #   "segoe" => {
    #     :normal => font_path
    #   }
    # )



		white_pages.each_with_index do |statements, page|
			render_card_page(card_geometry, icon_file, statements, false)
			start_new_page unless page >= white_pages.length-1
		end
		start_new_page unless white_pages.length == 0 || black_pages.length == 0
		black_pages.each_with_index do |statements, page|
			render_card_page(card_geometry, icon_file, statements, true)
			start_new_page unless page >= black_pages.length-1
		end
  end

  def content(params)

    # text @white_cards
    # text @black_cards
    # text @icon
    # text @one_per_page.to_s
    # text @rounded_corners.to_s

    render_cards nil, nil, nil, @icon, "cards.pdf", true, false, false, @card_geometry, @white_cards, @black_cards, true
  end

end