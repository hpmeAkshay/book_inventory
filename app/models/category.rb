class Category < ApplicationRecord
    has_many :books, dependent: :destroy
    has_many :sub_categories, dependent: :destroy
    validates :title, presence: true
end
