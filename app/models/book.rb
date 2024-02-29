class Book < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["author", "category_id", "cost", "created_at", "description", "id", "id_value", "language", "quantity", "sub_category_id", "title", "updated_at"]
  end
  has_many :sales, dependent: :destroy
  has_one :book_summary, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :sub_category, optional: true
  validates :title, presence: true
  validates :cost, presence: true
  validates :quantity, presence: true

  after_save :create_or_update_book_summary

  private

  def create_or_update_book_summary
    if book_summary.present?
      book_summary.update(
        total_quantity_sold: sales.sum(:quantity),
        total_revenue: sales.sum(:amount)
      )
    else
      BookSummary.create(
        book: self,
        total_quantity_sold: sales.sum(:quantity),
        total_revenue: sales.sum(:amount)
      )
    end
  end
end
