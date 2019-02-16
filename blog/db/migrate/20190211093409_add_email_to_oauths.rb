class AddEmailToOauths < ActiveRecord::Migration[5.2]
  def change
    add_column :oauths, :email, :string
  end
end
