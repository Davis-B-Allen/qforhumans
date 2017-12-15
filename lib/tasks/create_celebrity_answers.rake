# Make sure to include the desired .tsv file in lib/tsv
# The .tsv must have the following column_names
#   Topic
#   Answer
#   Level
#
#   It must also have the name of the celebrity in the first row, first column
#
# Call the task with:
# rails create_celebrity_answers[filename]

require 'csv'

desc "Create answers records for a given celebrity"
task :create_celebrity_answers, [:source_tsv] => [:environment] do |task, args|
  filename = args.source_tsv
  tsv_file = Rails.root.join('lib', 'tsv', filename)
  puts tsv_file

  parsed_file = CSV.read(tsv_file, { :col_sep => "\t" })
  column_names = parsed_file.shift

  celebrity_name = column_names[0]
  celeb = Celebrity.find_by(name: celebrity_name)

  parsed_file.each_with_index do |row, index|
    card_lens_name = row[column_names.index("Topic")]
    current_card = Card.find_by(lens_name: card_lens_name)

    answer = row[column_names.index("Answer")]
    current_level = row[column_names.index("Level")]
    puts "Creating celeb number #{index}"
    Answer.create!(celebrity: celeb, card: current_card, content: answer, level: current_level)
  end
end
