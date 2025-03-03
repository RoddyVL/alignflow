class Category < ApplicationRecord
  belongs_to :idea

  enum status: { pending: 0, selected: 1}

  validates :name, presence: true, uniqueness: { scope: :idea_id }
end
