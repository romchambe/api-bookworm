class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :quote, optional: :true

  validates :content, presence: :true, length: {minimum: 2}
end
