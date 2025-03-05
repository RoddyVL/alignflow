class Project < ApplicationRecord
  belongs_to :user
  has_many :niches, dependent: :destroy
  has_many :skills

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
