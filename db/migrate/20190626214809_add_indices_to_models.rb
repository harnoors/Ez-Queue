class AddIndicesToModels < ActiveRecord::Migration[5.2]
  def change
    add_index :guests, :created_at, unique: true
    add_index :moderators, :name, unique: true
    add_index :rooms, :accessCode, unique: true
  end
end
