class AddIsElectricToBikes < ActiveRecord::Migration[7.0]
  def change
    add_column :bikes, :is_electric, :boolean
  end
end
