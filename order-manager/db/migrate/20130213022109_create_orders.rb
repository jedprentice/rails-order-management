class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :order_date, :null => false
      t.decimal :vat, :null => false
      t.string :status, :null => false
      t.string :notes

      t.timestamps
    end
  end
end
