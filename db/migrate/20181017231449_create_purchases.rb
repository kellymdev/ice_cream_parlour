class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :day
      t.string :ingredient
      t.integer :quantity
      t.timestamps
    end
  end
end
