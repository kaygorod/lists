class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :user_id, null: false
      t.integer :list_id, null: false
      t.integer :rating,  null: false, default: "0"
      t.integer :comts,   null: false, default: "0"

      t.timestamps
    end
    add_index :items, :user_id
    add_index :items, :list_id
  end
end
