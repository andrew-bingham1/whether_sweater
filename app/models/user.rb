class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :api_key, presence: true
  
  has_secure_password
end