class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :vot,      null: false
      t.integer :item_id, null: false
      t.integer :user_id
      t.string :user_ip

      t.timestamps
    end
    add_index :votes, [:item_id, :user_id], unique: true
    add_index :votes, [:item_id, :user_ip], unique: true
    add_index :votes, :item_id
    add_index :votes, :user_id
    add_index :votes, :user_ip
  end
end
