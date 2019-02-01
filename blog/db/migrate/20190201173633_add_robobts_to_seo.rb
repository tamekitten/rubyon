class AddRobobtsToSeo < ActiveRecord::Migration[5.2]
  def change
    add_column :seos, :robots, :string
  end
end
