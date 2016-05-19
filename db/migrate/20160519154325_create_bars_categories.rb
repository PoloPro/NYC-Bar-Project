class CreateBarsCategories < ActiveRecord::Migration
  def change
    create_table :bars_categories do |t|
      t.integer :bar_id
      t.integer :category_id
    end
  end
end
