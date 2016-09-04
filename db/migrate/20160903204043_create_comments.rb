class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :item_id
      t.integer :list_id, null: false

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :item_id
    add_index :comments, :list_id
  end
end
