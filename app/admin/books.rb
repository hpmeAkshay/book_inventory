ActiveAdmin.register Book do
  permit_params :title, :description, :language, :cost, :quantity, :author, :sub_category_id, :category_id, :book_type
  menu priority: 2
  index do
    selectable_column
    column :title do |book|
      strong link_to book.title, admin_book_path(book)
    end
    column :description
    column :language
    column :category
    column :sub_category
    column :book_type
    column :cost
    column "Available quantity", :quantity do |book|
      content_tag(:div, book.quantity, style: "text-align: center;")
    end
    actions defaults: false do |book|
      link_to 'Sell', sell_admin_book_path(book), method: :put, class: 'button'
    end
  end

  filter :category
  filter :sub_category
  filter :title
  filter :language
  filter :cost

  action_item :upload_csv, only: :index do
    link_to 'Upload CSV', upload_csv_admin_books_path
  end

  collection_action :upload_csv, method: :get do
    render 'admin/books/upload_csv'
  end

  collection_action :import_csv, method: :post do
    csv_file = params[:csv]
    if csv_file.present? && csv_file.respond_to?(:read)
      csv_data = csv_file.read
      CSV.parse(csv_data, headers: true) do |row|
        book_attributes = row.to_hash
        existing_book = Book.find_by(title: book_attributes["title"], description: book_attributes["description"], language: book_attributes["language"], cost: book_attributes["cost"], quantity: book_attributes["quantity"], author: book_attributes["author"], sub_category_id: book_attributes["sub_category_id"], category_id: book_attributes["category_id"], book_type: book_attributes["book_type"])
        if existing_book.present?
          next
        else
          Book.create!(book_attributes)
        end
      end
      redirect_to admin_books_path, notice: 'CSV file uploaded and processed successfully.'
    else
      redirect_to upload_csv_admin_books_path, alert: 'Please select a CSV file.'
    end
  end
  
 
  member_action :sell, method: :put do
    @book = Book.find(params[:id])
    if @book.quantity > 0
      @book.update(quantity: @book.quantity - 1)
      Sale.create( 
        book: @book,
        quantity: 1,
        amount: @book.cost,
        sold_at: Time.current)
      redirect_to admin_books_path, notice: "Book sold successfully."
    else
      redirect_to admin_books_path, alert: "Unable to sell book. Quantity is already zero."
    end
  end

  action_item :sell, only: :show do
    link_to 'Sell Book', sell_admin_book_path(book), method: :put
  end
  
end
