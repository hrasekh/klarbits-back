class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.text :content, null: false
      t.uuid :uuid, null: false, index: { unique: true }
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, null: false, foreign_key: true 

      t.timestamps
    end
  end
end

