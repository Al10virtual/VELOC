class SetDefaultStatusForRental < ActiveRecord::Migration[7.0]
  def change
    change_column_default :rentals, :status, "pending"
  end
end
