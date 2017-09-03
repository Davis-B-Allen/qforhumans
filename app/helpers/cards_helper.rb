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
  def icon_for(card)
    case card.face_suit
    when 1
      "icon_150_heart.png"
    when 2
      "icon_150_club.png"
    when 3
      "icon_150_diamond.png"
    when 4
      "icon_150_spade.png"
    when 5
      "icon_150_club.png"
    when 6
      "icon_150_diamond.png"
    else
      "icon_150_heart.png"
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
