class CreateCelebrities < ActiveRecord::Migration[5.1]
  def change
    create_table :celebrities do |t|
      t.string :name
      t.string :wikilink

      t.timestamps
    end
  end
end
