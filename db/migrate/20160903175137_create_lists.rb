class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :user_id, null: false
      t.integer :views, null: false, default: "0"
      t.string :slug, unique: true

      t.timestamps
    end
    add_index :lists, :user_id
  end
end
