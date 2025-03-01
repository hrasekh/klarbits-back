class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.text :answer, null: false
      t.references :question, null: false, foreign_key: true
      t.boolean :is_correct, default: false, null: false

      t.timestamps
    end
  end
end
