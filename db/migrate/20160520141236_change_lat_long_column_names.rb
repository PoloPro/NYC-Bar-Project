class ChangeLatLongColumnNames < ActiveRecord::Migration
  def change
    rename_column :bars, :lat, :latitude
    rename_column :bars, :long, :longitude
  end
end
