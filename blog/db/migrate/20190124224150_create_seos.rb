class CreateSeos < ActiveRecord::Migration[5.2]
  def change
    create_table :seos do |t|
      t.string :keywords
      t.text :description
      t.string :title

      t.timestamps
    end

    add_reference :seos, :seoable, polymorphic: true
  end
end
