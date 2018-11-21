class RemoveIceCreamCountFromInventory < ActiveRecord::Migration[5.2]
  def change
    remove_column :inventories, :ice_creams, :integer
  end
end
