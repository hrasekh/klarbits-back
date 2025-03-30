class AddJwtColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :jti, :string, null: false
    add_column :users, :exp, :datetime
    add_index :users, :jti, unique: true
  end
end
