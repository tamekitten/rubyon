class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.integer :mark, null: false

      t.timestamps
    end

    add_index :marks, [:user_id, :post_id], unique: true
  end
end
