class CreateBikes < ActiveRecord::Migration[7.0]
  def change
    create_table :bikes do |t|
      t.string :bike_type
      t.string :wheel_size
      t.string :frame_material
      t.string :brand
      t.string :condition
      t.float :price_per_day
      t.float :price_per_week
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
