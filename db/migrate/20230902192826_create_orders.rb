class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dish, null: false, foreign_key: true
      # t.references :restaurant, null: false, foreign_key: true
      t.string :order_status
      t.integer :quantity
      t.decimal :total_amount

      t.timestamps
    end
  end
end
