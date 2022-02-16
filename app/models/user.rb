class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
         
  validates :name , presence: true, uniqueness: true, format:{with: /\A([^@\s]+)@(([a-zA-Z0-9]+\.)+[a-zA-Z.]{2,5})\z/}
  has_secure_password

  after_create { generate_token}	
  def generate_token
    token= SecureRandom.urlsafe_base64
    User.update(remember_token: token )
    
  end
  
end
