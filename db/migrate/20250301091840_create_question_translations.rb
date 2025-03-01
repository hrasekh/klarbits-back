class CreateQuestionTranslations < ActiveRecord::Migration[7.2]
  def change
    create_table :question_translations do |t|
      t.references :question, null: false, foreign_key: true
      t.string :locale, null: false
      t.text :content, null: false

      t.timestamps
    end
    add_index :question_translations, [:question_id, :locale], unique: true
  end
end
