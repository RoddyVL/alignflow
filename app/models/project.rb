class Project < ApplicationRecord
  belongs_to :user
  has_many :niches, dependent: :destroy
  has_many :skills

  validates :name, presence: true
end
