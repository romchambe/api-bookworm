class Quote < ApplicationRecord
  belongs_to :book
  has_one_attached :upload

  serialize :full_response

end
