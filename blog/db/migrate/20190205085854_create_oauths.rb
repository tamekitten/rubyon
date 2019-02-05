class CreateOauths < ActiveRecord::Migration[5.2]
  def change
    create_table :oauths do |t|
      t.string :provider, null: false
      t.references :user, null: false, foreign_key: true
      t.string :uid, null: false
      t.string :name
      t.string :location
      t.string :image_url
      t.string :url

      t.timestamps
    end

    add_index :oauths, [:provider, :uid], unique: true
  end
end
