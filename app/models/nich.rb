class Nich < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project
  has_one :avatar, dependent: :destroy
  has_one :offer, dependent: :destroy
  has_one :hypothesis_result, dependent: :destroy
  has_one :message, dependent: :destroy
  has_one :script, dependent: :destroy
  has_many :ai_responses, dependent: :destroy
  has_many :ideas, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  enum ai_status: { pending: 0, processing: 1, completed: 2, failed: 3 }
end
