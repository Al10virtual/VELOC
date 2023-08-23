class AddModelToBikes < ActiveRecord::Migration[7.0]
  def change
    add_column :bikes, :model, :string
  end
end
