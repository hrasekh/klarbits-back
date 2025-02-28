class CreateSubcategories < ActiveRecord::Migration[7.2]
  def change
    create_table :subcategories do |t|
      t.string :name, null: false
      t.string :slug, null: false, index: { unique: true }
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
