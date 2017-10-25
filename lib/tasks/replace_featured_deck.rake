# Make sure to include the desired .tsv file in lib/tsv
# Call the task with:
# rails replace_featured_deck[filename]

require 'csv'

desc "Replace the featured deck with a deck generated from a argument-specified tsv file in lib/tsv"
task :replace_featured_deck, [:source_tsv] => [:environment] do |task, args|

  def face_to_face_number(face_chars)
    if face_chars[0] =~ /[0-9]/
      face_chars[0]
    elsif ["T", "J", "Q", "K", "B", "R"].include?(face_chars[0])
      case face_chars[0]
      when "T"
        10
      when "J"
        11
      when "Q"
        12
      when "K"
        13
      when "B"
        14
      when "R"
        14
      else
        0
      end
    else
      0
    end
  end

  def face_to_face_suit(face_chars)
    case face_chars[1]
    when "H"
      1
    when "C"
      2
    when "D"
      3
    when "S"
      4
    when "J"
      if face_chars[0] == "B"
        5
      elsif face_chars[0] == "R"
        6
      else
        0
      end
    else
      0
    end
  end

  # Find the featured deck
  featured_deck = Deck.featured
  puts featured_deck.name

  # if the featured deck exists, delete it
  if featured_deck
    featured_deck.destroy
  end

  # create new featured deck
  # set new deck as featured (currently unnecessary as Deck.featured just returns Deck.last)
  new_deck = Deck.create!(name: "Questions for Humans")

  # start importing cards from tsv

  filename = args.source_tsv
  tsv_file = Rails.root.join('lib', 'tsv', filename)
  puts tsv_file

  parsed_file = CSV.read(tsv_file, { :col_sep => "\t" })
  column_names = parsed_file.shift
  parsed_file.each_with_index do |card, index|

    face = card[column_names.index("Face")]
    face_number = face_to_face_number(face).to_i
    face_suit = face_to_face_suit(face).to_i

    lens_prefix = card[column_names.index("LensPrefix")]
    lens_name = card[column_names.index("Topic")]
    category = card[column_names.index("Level")]
    me_question = card[column_names.index("Text")]

    card_remote_image_url = card[column_names.index("CardBackImageUrl")]

    puts "\n\nlens_prefix: #{lens_prefix}\nlens_name: #{lens_name}\nface_number: #{face_number}\nface_suit: #{face_suit}\ncategory: #{category}\nme_question: #{me_question}\n\n"

    card = new_deck.cards.create!(
    	lens_prefix: lens_prefix,
    	lens_name: lens_name,
    	face_number: face_number,
    	face_suit: face_suit,
    	category: category,
      me_reason: "",
    	me_question: me_question,
    	we_reason: "",
    	we_question: ""
    )

    card.remote_image_url = card_remote_image_url
    card.save!

  end
end
