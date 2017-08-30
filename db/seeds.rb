# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

qforhum_deck = Deck.create!(name: "Questions for Humans")

qforhum_deck.cards.create!(
  lens_prefix: "The Lens of",
  lens_name: "You"
)

qforhum_deck.cards.create!(
  lens_prefix: "The Lens of",
  lens_name: "People"
)

qforhum_deck.cards.create!(
  lens_prefix: "The Lens of the",
  lens_name: "World"
)
