class User < ApplicationRecord
  before_save { self.email = email.downcase } 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username, presence: true, length: { minimum: 2, maximum: 255 }  
  validates :email, presence: true, length: { minimum: 3, maximum: 255 },
        format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } 
  validates :password, presence: true, length: { minimum: 6 }
  
  has_many :notes
  has_many :books

  has_secure_password
end
