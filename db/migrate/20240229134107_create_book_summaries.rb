class CreateBookSummaries < ActiveRecord::Migration[7.1]
  def change
    create_table :book_summaries do |t|
      t.references :book, foreign_key: true
      t.integer :total_quantity_sold, default: 0
      t.decimal :total_revenue, default: 0.0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
