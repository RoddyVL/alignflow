class Nich < ApplicationRecord
  belongs_to :project
  has_one :avatar, dependent: :destroy
  has_one :offer, dependent: :destroy
  has_one :hypothesis_result, dependent: :destroy
  has_one :message, dependent: :destroy
  has_one :script, dependent: :destroy
  has_many :ai_responses, dependent: :destroy

  validates :name, presence: true

  enum ai_status: { pending: 0, processing: 1, completed: 2, failed: 3 }

  # Définir les statuts possibles
  UNSELECTED = 0
  SELECTED = 1

  private
  # Méthode pour vérifier si la niche est sélectionnée
  def selected?
    status == SELECTED
  end

  def unselected?
    status == UNSELECTED
  end
end
