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
  lens_name: "You",
  face_number: 1,
	face_suit: 1,
	category: "Departure",
	me_reason: "Because it is important to know who you are, ask yourself:",
	me_question: "Who am I?",
	we_reason: "The word 'you' can refer to one person or many. Use these lenses with all groups of people, whether a couple, family, business, community, classroom, club, or any other collection. The lenses are the same although the wording might change. We ask ourselves:",
	we_question: "Who are we? What defines us?"
)

qforhum_deck.cards.create!(
  lens_prefix: "The Lens of",
  lens_name: "People",
  face_number: 1,
	face_suit: 2,
	category: "Departure",
	me_reason: "So that you can keep your relationships in perspective, ask yourself:",
	me_question: "Who is important to me?",
	we_reason: "Although we are important to each other, other people count too. We ask ourselves:",
	we_question: "Who is important to us collectively?"
)

qforhum_deck.cards.create!(
  lens_prefix: "The Lens of the",
  lens_name: "World",
  face_number: 1,
	face_suit: 3,
	category: "Departure",
	me_reason: "Because you cannot function effectively without knowing how the world works, ask yourself:",
	me_question: "What do I need to know?",
	we_reason: "Because none of us function effectively if we don't understand our place in the grand scheme of things, we ask ourselves:",
	we_question: "How do we fit together and where do we fit in?"
)

qforhum_deck.cards.create!(
  lens_prefix: "The Lens of",
  lens_name: "Work",
  face_number: 1,
	face_suit: 4,
	category: "Departure",
	me_reason: "So that you will spend your time wisely, ask yourself:",
	me_question: "What do I want to do?",
	we_reason: "Because people cannot work at cross purposes and get much done, we ask ourselves:",
	we_question: "What do we want to do together? What is best done apart?"
)

qforhum_deck.cards.create!(
  lens_prefix: "The Lens of",
  lens_name: "Gratitude",
  face_number: 2,
	face_suit: 1,
	category: "Foundation",
	me_reason: "So that you can get in the habit of counting your blessings and thanking those who have been good to you, ask yourself:",
	me_question: "What am I grateful for? Whom do I thank? How do I thank them?",
	we_reason: "Everything deserves our gratitude because otherwise we might take things for granted. We ask ourselves:",
	we_question: "How do we thank the world for being there for us?"
)
