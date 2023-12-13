class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_num
      t.integer :total
      t.integer :tax_amount
      t.datetime :order_date

      t.timestamps
    end
  end
end
