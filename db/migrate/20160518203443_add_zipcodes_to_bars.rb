class AddZipcodesToBars < ActiveRecord::Migration
  def change
    add_column :bars, :zipcode, :string
  end
end
