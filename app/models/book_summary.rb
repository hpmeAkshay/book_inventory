# app/models/book_summary.rb
class BookSummary < ApplicationRecord
    belongs_to :book
    delegate :sales, to: :book
  
    def total_quantity_sold
      sales.sum(:quantity)
    end
  
    def total_revenue
      sales.sum(:amount)
    end
  end
  