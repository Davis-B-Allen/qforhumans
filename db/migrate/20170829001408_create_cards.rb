class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :lens_prefix
      t.string :lens_name
      t.references :deck, foreign_key: true

      t.timestamps
    end
  end
end
