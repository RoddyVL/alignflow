class Idea < ApplicationRecord
  belongs_to :nich
  has_many :categories, dependent: :destroy

  enum status: { pending: 0, selected: 1 }

  validates :description, presence: true, uniqueness: { scope: :nich_id }
end
