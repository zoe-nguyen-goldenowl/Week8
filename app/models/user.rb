class User < ApplicationRecord
  validates :name , presence: true, uniqueness: true, format:{with: /\A([^@\s]+)@(([a-zA-Z0-9]+\.)+[a-zA-Z.]{2,5})\z/}
  has_secure_password
end
