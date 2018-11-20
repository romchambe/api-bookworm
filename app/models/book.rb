class Book < ApplicationRecord
  attr_accessor :quote_count 
  belongs_to :user
  has_many :quotes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: :true, length: {minimum: 2}
  validates :author, presence: :true, length: {minimum: 2}

  def with_quote_count
    book_attributes = self.attributes
    book_attributes[:quote_count] = self.quotes.length
    book_attributes
  end
end
