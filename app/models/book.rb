class Book < ApplicationRecord
  belongs_to :user
  has_many :quotes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: :true, length: {minimum: 2}
  validates :author, presence: :true, length: {minimum: 2}
end
