# Make sure to include the desired .tsv file in lib/tsv
# Call the task with:
# rails create_celebrities[filename]

require 'csv'

desc "Delete current celebrities and replace with celebrities from tsv file"
task :create_celebrities, [:source_tsv] => [:environment] do |task, args|
  Celebrity.delete_all

  filename = args.source_tsv
  tsv_file = Rails.root.join('lib', 'tsv', filename)
  puts tsv_file

  parsed_file = CSV.read(tsv_file, { :col_sep => "\t" })
  column_names = parsed_file.shift
  parsed_file.each_with_index do |celebrity, index|
    name = celebrity[column_names.index("Name")]
    wikilink = celebrity[column_names.index("Wikipedia")]
    Celebrity.create!(name: name, wikilink: wikilink)
  end
end
