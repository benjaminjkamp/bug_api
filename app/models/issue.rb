class Issue < ApplicationRecord
  belongs_to :app
  belongs_to :location 

  has_many :steps
  has_many :user_issues
  has_many :users, through: :user_issues
  has_many :comments

end
