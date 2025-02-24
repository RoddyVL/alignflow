class Segment < ApplicationRecord
  belongs_to :idea

  enum status: { pending: 0, selected: 1 }
end
