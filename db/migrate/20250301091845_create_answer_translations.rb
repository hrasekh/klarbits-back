class CreateAnswerTranslations < ActiveRecord::Migration[7.2]
  def change
    create_table :answer_translations do |t|
      t.references :answer, null: false, foreign_key: true
      t.string :locale, null: false
      t.text :content

      t.timestamps
    end
    add_index :answer_translations, [:answer_id, :locale], unique: true
  end
end
