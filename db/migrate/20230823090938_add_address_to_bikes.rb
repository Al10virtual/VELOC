class AddAddressToBikes < ActiveRecord::Migration[7.0]
  def change
    add_column :bikes, :address, :string
  end
end
