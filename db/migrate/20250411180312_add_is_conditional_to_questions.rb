class AddIsConditionalToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :is_conditional, :boolean, default: false, null: false
    add_column :questions, :condition, :integer
    
    add_index :questions, :is_conditional
    add_index :questions, :condition, where: "is_conditional = true"
  end
end
