class Project < ApplicationRecord
  belongs_to :user
  has_many :niches, dependent: :destroy

  validates :name, presence: true
end
