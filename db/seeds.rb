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

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Fairness",
	face_number: 2,
	face_suit: 2,
	category: "Foundation",
	me_reason: "Because fairness is a human invention, not a natural phenomenon, ask yourself:",
	me_question: "What does fairness mean to me? When is it OK to be unfair?",
	we_reason: "Because everyone deserves fair treatment, we ask ourselves: ",
	we_question: "Do we treat some people more fairly than others?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Wealth",
	face_number: 2,
	face_suit: 3,
	category: "Foundation",
	me_reason: "Wealth is the measure of the extent to which you have what you want. Ask yourself:",
	me_question: "Where do the things I want come from? How will I consume wisely?",
	we_reason: "Because other people have things we want, we ask ourselves:",
	we_question: "What will we give others so we get what we want?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Motivation",
	face_number: 2,
	face_suit: 4,
	category: "Foundation",
	me_reason: "Because you will do better work if you know why you want to do it, ask yourself:",
	me_question: "What will I do only if I am rewarded? What will I do for its own sake?",
	we_reason: "Even when our work requires solitary effort, it is hard to concentrate if we feel lonely. We ask ourselves:",
	we_question: "How will we keep each other motivated?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Boss",
	face_number: 3,
	face_suit: 1,
	category: "Core",
	me_reason: "Because it is important to know who will bear ultimate responsibility for your life, ask yourself:",
	me_question: "Who is the boss of me? Who do I want as boss? Who am I living my life for?",
	we_reason: "Even if some of us have more power than others, we all need to care about each other. We ask ourselves:",
	we_question: "Do we have each other's backs?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Family",
	face_number: 3,
	face_suit: 2,
	category: "Core",
	me_reason: "Rather than think of family in terms of blood relationships, consider it in terms of motivation to help. Ask yourself:",
	me_question: "Who would help me even though they don't like me? Who would I help even though I don't like them?",
	we_reason: "It is important to know what kind of group we are. We ask ourselves:",
	we_question: "Do we think of ourselves as family?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Nature",
	face_number: 3,
	face_suit: 3,
	category: "Core",
	me_reason: "Because we all share the same planet, ask yourself:",
	me_question: "What is my relationship with nature?",
	we_reason: "Because we must think of those who will be born after we die, we ask ourselves:",
	we_question: "Are we doing our part to leave a healthy planet after we are gone?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Hierarchy",
	face_number: 3,
	face_suit: 4,
	category: "Core",
	me_reason: "Rather than think in terms of power relationships, think about what is important. Ask yourself:",
	me_question: "Whose interests come before mine? Whose interests come after mine?",
	we_reason: "It is natural to put 'us' before 'them' but that isn't always wise. We ask ourselves:",
	we_question: "When are we more important than other people? When are they more important?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Experiences",
	face_number: 4,
	face_suit: 1,
	category: "Sense",
	me_reason: "Consider your life in terms of experience rather than accomplishment. Ask yourself:",
	me_question: "What experiences do I want to have? What is essential to those experiences?",
	we_reason: "Whatever the nature of our relationships, we create experiences. We ask ourselves:",
	we_question: "What experiences do we create for ourselves and for others?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Friendship",
	face_number: 4,
	face_suit: 2,
	category: "Sense",
	me_reason: "Rather than think of friendships in terms of declared allegiances, consider them in terms of motivation to help. Ask yourself:",
	me_question: "Who would help me because they like me? Who would I help because I like them?",
	we_reason: "It is important to think about how we relate to each other. We ask ourselves:",
	we_question: "Do we think of ourselves as friends?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Attitude",
	face_number: 4,
	face_suit: 3,
	category: "Sense",
	me_reason: "Because you need to approach things with the right frame of mind, ask yourself:",
	me_question: "What is my attitude with respect to: problems? learning? change? risk?",
	we_reason: "Because cooperation requires us to be reliable, we ask ourselves:",
	we_question: "Who do we trust? Why? Who do we distrust? Why?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Product",
	face_number: 4,
	face_suit: 4,
	category: "Sense",
	me_reason: "Because one goal of work is to produce something of value, ask yourself:",
	me_question: "What am I producing? What needs do I fill? How? For whom? Why?",
	we_reason: "We have needs, but so do others. We ask ourselves:",
	we_question: "What are we producing for each other? What are we producing for others?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Values",
	face_number: 5,
	face_suit: 1,
	category: "Support",
	me_reason: "You need to know what is important to you. Ask yourself:",
	me_question: "What do I value? Why?",
	we_reason: "Because shared values are as important as shared interests and motivations, we ask ourselves:",
	we_question: "What values do we share? What differences do we tolerate in ourselves and others?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Community",
	face_number: 5,
	face_suit: 2,
	category: "Support",
	me_reason: "Rather than think of community in terms of geography or common interest, consider it in terms of motivation to help. Ask yourself:",
	me_question: "Who would help me even though they don't know me? Who would I help even though I don't know them?",
	we_reason: "Rituals help define community. We ask ourselves:",
	we_question: "What are our rules and traditions?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Needs",
	face_number: 5,
	face_suit: 3,
	category: "Support",
	me_reason: "We survive and thrive by meeting each other's needs. Ask yourself:",
	me_question: "What do I need? What is needed of me?",
	we_reason: "People feel good about themselves by being of use to others.",
	we_question: "We ask ourselves: How do we encourage others to express their needs to us?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Return on Investment",
	face_number: 5,
	face_suit: 4,
	category: "Support",
	me_reason: "Society and many individuals have made a direct and indirect investment in you. Ask yourself:",
	me_question: "How will I pay back the investment made in me? How will I pay it forward?",
	we_reason: "Because people rise to meet expectations, we ask ourselves:",
	we_question: "Do we make it clear what we expect of each other?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Character",
	face_number: 6,
	face_suit: 1,
	category: "Relationships",
	me_reason: "Because character becomes destiny, ask yourself:",
	me_question: "In what ways does my character need to be improved? What am I doing to develop better habits?",
	we_reason: "People can inspire each other to be good or pressure each other to be bad. We ask ourselves:",
	we_question: "Are we being civilized?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Judgment",
	face_number: 6,
	face_suit: 2,
	category: "Relationships",
	me_reason: "Although people do not like to be judged, sometimes it must be done. Ask yourself:",
	me_question: "When must I judge others? When must I reserve judgment? How will I ensure fairness?",
	we_reason: "Nobody likes being treated unfairly. We ask ourselves:",
	we_question: "How will we balance liberty and justice?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Followership",
	face_number: 6,
	face_suit: 3,
	category: "Relationships",
	me_reason: "Because followers have responsibilities, ask yourself:",
	me_question: "Have I chosen my leaders wisely? Am I blaming leaders for things that could be my responsibility?",
	we_reason: "Because we all have rights, we ask ourselves:",
	we_question: "Do we tolerate dissent? What are the limits to our loyalty?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Leadership",
	face_number: 6,
	face_suit: 4,
	category: "Relationships",
	me_reason: "Because leaders have responsibilities, ask yourself:",
	me_question: "Why do I want to lead? Am I acting in the best interests of those who follow?",
	we_reason: "Because others do as we do, not as we say, we ask ourselves:",
	we_question: "Are we setting a good example for others?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Good vs. Nice",
	face_number: 7,
	face_suit: 1,
	category: "Choice",
	me_reason: "Because the opposite of Good is Evil, and the opposite of Nice is Unlikable, ask yourself:",
	me_question: "Do I choose to be Good knowing that in order to avoid being Evil I might have to do things people will not like?",
	we_reason: "If we only listen to each other we can fail to see the truth. We ask ourselves:",
	we_question: "Are we blind to our true nature?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "War vs. Peace",
	face_number: 7,
	face_suit: 2,
	category: "Choice",
	me_reason: "Because large groups of people can find themselves caught up in massive endeavors, ask yourself:",
	me_question: "How will I be Good when everyone else is Evil?",
	we_reason: "Before we use force to settle disagreements, we ask ourselves:",
	we_question: "What makes us so sure we are right?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Knowing vs. Doing",
	face_number: 7,
	face_suit: 3,
	category: "Choice",
	me_reason: "Because it is action that counts, ask yourself:",
	me_question: "When will I know enough to act?  What am I doing now that could benefit from a better understanding?",
	we_reason: "Engagement style matters. We ask ourselves:",
	we_question: "Are we proactive or reactive?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Now vs. Later",
	face_number: 7,
	face_suit: 4,
	category: "Choice",
	me_reason: "Because more often than not good things come to those who wait, ask yourself:",
	me_question: "What rewards can I put off until later so I can concentrate on doing my best work now?",
	we_reason: "If we want the future to be better than the past then we must make sacrifices. We ask ourselves:",
	we_question: "How will we reward taking a long-term view?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Health",
	face_number: 8,
	face_suit: 1,
	category: "Energy",
	me_reason: "Because you must be healthy to live well, ask yourself:",
	me_question: "Am I physically, mentally, and spiritually healthy? What do I need to improve?",
	we_reason: "If we care about each other we can figure out the rest and if we don't care then it doesn't matter. We ask ourselves:",
	we_question: "Do we take care of each other? How?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Common Good",
	face_number: 8,
	face_suit: 2,
	category: "Energy",
	me_reason: "Because we are all in it together, ask yourself:",
	me_question: "How can I make the world a better place?",
	we_reason: "Although it is natural to focus on what we care about the most, we must still ask ourselves:",
	we_question: "Are we being good citizens?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Economy",
	face_number: 8,
	face_suit: 3,
	category: "Energy",
	me_reason: "Because the economy is about more than just money, ask yourself:",
	me_question: "What is more important than money? What is less important? Do I have what I need for the future?",
	we_reason: "Because the economy goes through cycles, we ask ourselves:",
	we_question: "How will we help each other get through hard times?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Power",
	face_number: 8,
	face_suit: 4,
	category: "Energy",
	me_reason: "Power is the ability to get what you want. Ask yourself:",
	me_question: "Do I already have enough power? Do I need more power? Why? How will I get it?",
	we_reason: "Because power corrupts, we ask ourselves:",
	we_question: "Are some of us benefiting at the expense of others? How do we curb the power of the greedy?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Thinking",
	face_number: 9,
	face_suit: 1,
	category: "Vitality",
	me_reason: "Because you need to know how to think, ask yourself:",
	me_question: "Can I think: mathematically? verbally? emotionally?",
	we_reason: "Because 'group think' is a real problem, we ask ourselves: ",
	we_question: "Do we encourage outsiders to question us? Have we gone off the rails?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Crowd",
	face_number: 9,
	face_suit: 2,
	category: "Vitality",
	me_reason: "People tend to follow each other rather than think for themselves. Ask yourself:",
	me_question: "How am I influenced by other people? Who should influence me more? Who should influence me less?",
	we_reason: "Because a crowd can take on a life of its own, we as ourselves.",
	we_question: "Do we respect the rights of the individual and of the outsider?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Markets",
	face_number: 9,
	face_suit: 3,
	category: "Vitality",
	me_reason: "Markets set prices and bring people together to trade. Ask yourself:",
	me_question: "What markets do I operate in? How can I be more successful in the market for who I am?",
	we_reason: "There is no substitute for doing the right thing. We ask ourselves:",
	we_question: "Are we blaming markets for our own bad behavior?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Unknown",
	face_number: 9,
	face_suit: 4,
	category: "Vitality",
	me_reason: "Because the Unknown is bigger than the Known, ask yourself:",
	me_question: "What questions am I failing to ask? Have I left room for the Unknown?",
	we_reason: "Because sometimes 'nobody knows' is the right answer, we ask ourselves:",
	we_question: "Are we comfortable with uncertainty and doubt?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Self-Love",
	face_number: 10,
	face_suit: 1,
	category: "Love",
	me_reason: "Because you will not be happy if you do not believe you are worthy of love, ask yourself:",
	me_question: "How can I accept myself unconditionally as I am?",
	we_reason: "Most people want to be part of something bigger than themselves. We ask ourselves:",
	we_question: "Are we bigger than the sum of our parts?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Loving Others",
	face_number: 10,
	face_suit: 2,
	category: "Love",
	me_reason: "So that you can fulfill your potential as a human, ask yourself:",
	me_question: "Who do I love? Why? How? Who loves me? Why? How?",
	we_reason: "There is a big difference between loving and being loved. We ask ourselves:",
	we_question: "Are we making the effort that loving requires?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Loving Life",
	face_number: 10,
	face_suit: 3,
	category: "Love",
	me_reason: "So that you can seize every day and make the most of it, ask yourself:",
	me_question: "What gets me up every morning?",
	we_reason: "Moods are infectious. We ask ourselves:",
	we_question: "How is our morale? How can we make it better?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Love of the Work",
	face_number: 10,
	face_suit: 4,
	category: "Love",
	me_reason: "Because loving what you do trumps skill and aptitude, ask yourself:",
	me_question: "What do I love to do?",
	we_reason: "Passionate people do what needs to be done, even the parts they hate doing. We ask ourselves:",
	we_question: "How will we help each other do the things we do not like doing?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Forgiveness",
	face_number: 11,
	face_suit: 1,
	category: "Force",
	me_reason: "You must accept the past because it cannot be changed. Ask yourself:",
	me_question: "Can I forgive others? Can I forgive myself? Do I? Will I?",
	we_reason: "Sometimes a desire for revenge can overwhelm our better nature. We ask ourselves:",
	we_question: "Are we promoting hatred and ignorance or love and understanding?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Empathy",
	face_number: 11,
	face_suit: 2,
	category: "Force",
	me_reason: "Because people need you to understand them, ask yourself:",
	me_question: "What would I feel if I were them? What would I think if I were them? What would I do if I were them?",
	we_reason: "Because even our enemies have rights, we ask ourselves:",
	we_question: "Do we treat others in ways we would find abhorrent?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Entropy",
	face_number: 11,
	face_suit: 3,
	category: "Force",
	me_reason: "Because there is a natural tendency for things to fall apart, ask yourself",
	me_question: "How will I resist the forces of chaos?",
	we_reason: "Some problems, such as a mathematical proof, can be solved once for all time. Other problems, such as maintaining a loving relationship, require constant effort. We ask ourselves:",
	we_question: "Which of our problems can be solved once for all time and which require constant effort?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Salesmanship",
	face_number: 11,
	face_suit: 4,
	category: "Force",
	me_reason: "Because sometimes other people need persuading, ask yourself:",
	me_question: "What do people need? Can I help them? How can I get them to want my help?",
	we_reason: "Because making the sale is the beginning, not the end, we ask ourselves:",
	we_question: "Are we delivering on our promises?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Personal Narrative",
	face_number: 12,
	face_suit: 1,
	category: "Story",
	me_reason: "To know where you are going, ask yourself:",
	me_question: "What has been my story so far? What kind of experiences have I set myself up to have?",
	we_reason: "There is a thread that runs through everything that we do. We ask ourselves:",
	we_question: "What is our plot and theme?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Human Condition",
	face_number: 12,
	face_suit: 2,
	category: "Story",
	me_reason: "Because we are all brothers and sisters, ask yourself:",
	me_question: "What do I have in common with everyone? How can I be of service to mankind?",
	we_reason: "We are part of a greater whole. We ask ourselves:",
	we_question: "How will we care about everyone and not just each other?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Mythology",
	face_number: 12,
	face_suit: 3,
	category: "Story",
	me_reason: "In your search for meaning, instead of only describing the world scientifically, ask yourself:",
	me_question: "What invented stories are useful in making sense of the world? What do I accept on faith?",
	we_reason: "A story can ring true without being literally true. We ask ourselves:",
	we_question: "Do we expect or require people to accept our stories as the absolute truth?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of the",
	lens_name: "Hero's Journey",
	face_number: 12,
	face_suit: 4,
	category: "Story",
	me_reason: "Because the world needs to be saved, ask yourself:",
	me_question: "When will I put myself at risk for the benefit of others? What do I care about more than life itself?",
	we_reason: "Hero's need mentors. We ask ourselves:",
	we_question: "How do we help others on their journey?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Honesty",
	face_number: 13,
	face_suit: 1,
	category: "Virtue",
	me_reason: "To know thyself you must know thy truth. Ask yourself:",
	me_question: "Am I who I say I am?",
	we_reason: "Because we all risk believing things merely because others do, we ask ourselves:",
	we_question: "Do we challenge each other's beliefs and keep each other honest?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Accountability",
	face_number: 13,
	face_suit: 2,
	category: "Virtue",
	me_reason: "So that others can help you live up to your potential, ask yourself",
	me_question: "Who holds me accountable?",
	we_reason: "Because accountability requires a group effort, we ask ourselves:",
	we_question: "How do we hold each other accountable?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Growth",
	face_number: 13,
	face_suit: 3,
	category: "Virtue",
	me_reason: "So that you will never grow old, ask yourself:",
	me_question: "How will I become more knowledgeable, skilled, and wise?",
	we_reason: "Because curious people cannot do it all alone, we ask ourselves:",
	we_question: "Will we make time and do the work to help the curious?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Integrity",
	face_number: 13,
	face_suit: 4,
	category: "Virtue",
	me_reason: "So that you can live at peace with your conscience, ask yourself:",
	me_question: "What are the rules that I live by? Do I do what I say I will do?",
	we_reason: "We must reconcile our relationship with our conscience and with each other. ",
	we_question: "What do we consider to be immoral? What is our code of ethics?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Mortality",
	face_number: 14,
	face_suit: 5,
	category: "Destiny",
	me_reason: "Nobody asked to be born but now that we are here we must make the most of it. Ask yourself:",
	me_question: "Is doing what I am doing worth my time?",
	we_reason: "Because everyone is running like death is behind them because death is behind them, we ask ourselves:",
	we_question: "Are we worth other people's time?"
)

qforhum_deck.cards.create!(
	lens_prefix: "The Lens of",
	lens_name: "Your Secret Purpose",
	face_number: 14,
	face_suit: 6,
	category: "Destiny",
	me_reason: "To make sure you are working toward your true purpose, ask yourself:",
	me_question: "Why do I do what I do?",
	we_reason: "There will be a world full of people after we are gone. For our purpose to be noble we must ask ourselves:",
	we_question: "Why should anyone care that we once existed?"
)
