class SubCategory < ApplicationRecord
    has_many :books, dependent: :destroy
    belongs_to :category, optional: true
    validates :name, presence: true
end
