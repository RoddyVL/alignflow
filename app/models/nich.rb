class Nich < ApplicationRecord
  belongs_to :project
  has_many :avatars, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :hypothesis_results, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :scripts, dependent: :destroy
  has_many :ai_responses, dependent: :destroy

  validates :name, presence: true

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
