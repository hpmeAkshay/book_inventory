class AddTypeToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :book_type, :string
  end
end
