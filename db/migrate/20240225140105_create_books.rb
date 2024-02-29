class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :language
      t.decimal :cost
      t.integer :quantity
      t.string :author
      t.references :sub_category
      t.references :category

      t.timestamps
    end
  end
end
