class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.references :game
      t.integer :temperature
      t.decimal :milk_price
      t.decimal :sugar_price
      t.integer :ice_creams_made
      t.integer :ice_creams_sold
      t.decimal :ice_cream_price
      t.decimal :profit
      t.timestamps
    end
  end
end
