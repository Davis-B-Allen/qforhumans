class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :level
      t.references :card, foreign_key: true
      t.references :celebrity, foreign_key: true

      t.timestamps
    end
  end
end
