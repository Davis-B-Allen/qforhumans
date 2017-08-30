class AddDataToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :face_number, :integer
    add_column :cards, :face_suit, :integer
    add_column :cards, :category, :string
    add_column :cards, :me_reason, :text
    add_column :cards, :me_question, :text
    add_column :cards, :we_reason, :text
    add_column :cards, :we_question, :text
  end
end
