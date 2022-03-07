class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :user_issues
  has_many :issues, through: :user_issues
end
