class CreateDishOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :dish_orders do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :order_status
      t.integer :quantity
      t.decimal :total_amount
      t.timestamps
    end
  end
end
