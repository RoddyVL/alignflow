require 'rails_helper'

RSpec.describe Idea, type: :model do
  it { should validate_presence_of(:description) }
  it { should validate_uniqueness_of(:description).scoped_to(:nich_id) }
    it { should have_db_column(:status).of_type(:integer) }
    it { should have_db_column(:nich_id) }


  # Pour cela je vais créer une première instance d'idea qui servira de référence
  let(:nich1) { create(:nich) }
  let(:nich2) { create(:nich) }

  let!(:idea_reference) { create(:idea, description: "Idea", nich: nich1) }

  # Puis je créerait 1 exemple similaire à idea_reference mais avec un Nich_id différent et cela devra être valide
  it "it's should be validate with 2 duplicate description for 2 differents niches" do
    idea = build(:idea, description: "Idea", nich: nich2)
    expect(idea).to be_valid
  end

  # Puis je vais créer un exemple similaire à idea_reference avec un nich_id similaire et cela ne devra pas être valide.
  it "it's should not be valid with two duplicate description within the same idea" do
    idea = build(:idea, description: "Idea", nich: nich1)
    expect(idea).not_to be_valid
    expect(idea.errors[:description]).to include("has already been taken")
  end
end

# Je cherche à valider que wihtin the same nich, 2 ideas can't have the same name
