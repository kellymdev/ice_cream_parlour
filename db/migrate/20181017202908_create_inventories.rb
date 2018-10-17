class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.references :game
      t.integer :milk, default: 0
      t.integer :sugar, default: 0
      t.integer :ice_creams, default: 0
      t.decimal :balance, default: 0
      t.timestamps
    end
  end
end
