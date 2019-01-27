class AddPostCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :posts_count, :integer, null: false, default: 0
    change_column_null :users, :comments_count, false
    change_column_default :users, :comments_count, from: nil, to: 0
  end
end
