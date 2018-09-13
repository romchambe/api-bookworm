class Scan < ApplicationRecord
  belongs_to :user
  has_one_attached :upload

  serialize :full_response
end
