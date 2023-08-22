class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.integer :total_price
      t.date :start_date
      t.date :end_date
      t.string :status
      t.references :bike, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
