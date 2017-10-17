module CardsHelper

  # return correct card suit for given card
  def suit_for(card)
    case card.face_suit
    when 1
      "hearts"
    when 2
      "clubs"
    when 3
      "diamonds"
    when 4
      "spades"
    when 5
      "joker"
    when 6
      "joker"
    else
      "unknown"
    end
  end

  # return correct card suit icon for given card
  def icon_char_for(card)
    case card.face_suit
    when 1
      "♥"
    when 2
      "♣"
    when 3
      "♦"
    when 4
      "♠"
    when 5
      "♣"
    when 6
      "♦"
    else
      "♠"
    end
  end

  # Return correct string character for face number for given card
  def face_number_for(card)
    case card.face_number
    when 1
      "A"
    when 2,3,4,5,6,7,8,9,10
      card.face_number.to_s
    when 11
      "J"
    when 12
      "Q"
    when 13
      "K"
    when 14
      ""
    else
      "?"
    end
  end

  def full_name_for(card)
    "#{card.lens_prefix} #{card.lens_name}"
  end

end
