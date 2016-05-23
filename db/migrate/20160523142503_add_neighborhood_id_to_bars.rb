class AddNeighborhoodIdToBars < ActiveRecord::Migration
  def change
    add_column :bars, :neighborhood_id, :integer
  end
end
