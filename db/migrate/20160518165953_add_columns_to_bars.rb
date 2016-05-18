class AddColumnsToBars < ActiveRecord::Migration
  def change
    add_column :bars, :yelp_id, :string
    add_column :bars, :yelp_rating, :integer
  end
end
