class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body, null: false
      t.references :user, foreign_key: true, null: false
      t.boolean :visible, default: true, null: false

      t.timestamps
    end
    add_index :posts, :title, unique: true
  end
end
