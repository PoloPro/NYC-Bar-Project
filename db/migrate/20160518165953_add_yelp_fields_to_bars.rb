class AddYelpFieldsToBars < ActiveRecord::Migration
  def change
    add_column :bars, :yelp_id, :string
    add_column :bars, :yelp_rating, :float
  end
end
