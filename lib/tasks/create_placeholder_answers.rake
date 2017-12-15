# Call the task with:
# rails create_placeholder_answers

desc "Create placeholder answers to all cards for all existing celebrities"
task create_placeholder_answers: [:environment] do
  Answer.destroy_all

  featured_deck = Deck.featured
  Celebrity.all.each do |celeb|
    featured_deck.cards.each do |acard|
      Answer.create(level: 1, card: acard, celebrity: celeb, content: "I don't know.")
    end
  end

end
