class AddOrderToScenes < ActiveRecord::Migration[6.0]
  def change
    add_column :scenes, :order, :integer
  end
end
