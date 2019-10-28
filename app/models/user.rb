class User < ApplicationRecord
  has_secure_password

  has_many :videos
  
  validates :username, uniqueness: true, presence: true, length: { in: 3..20}
  validates :password, presence: true, length: { in: 6..20}
end
