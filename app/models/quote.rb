class Quote < ApplicationRecord
  belongs_to :book
  has_one_attached :upload
  has_many :comments

  validates :content, presence: :true, length: {minimum: 2}
end
