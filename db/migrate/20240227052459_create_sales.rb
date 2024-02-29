class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.references :book, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :amount, precision: 10, scale: 2
      t.datetime :sold_at

      t.timestamps
    end
  end
end
