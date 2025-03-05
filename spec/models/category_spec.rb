require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_db_column(:status).of_type(:integer) }

  # créer 2 idea
  let(:idea1) { create(:idea) }
  let(:idea2) { create(:idea) }

  # créer une category avec un name_reference
  let!(:category_reference) { create(:category, name: "name", idea: idea1)}

  # créer 1 test avec une category avec un nom similaire à name_reference mais avec une idea différente
  it "it's should be valide with two duplicate names for 2 differents idea" do
    category = build(:category, name: "name", idea: idea2)
    expect(category).to be_valid
  end

  # créer une category avec un name similaire à name_reference et un idea similaire
  it "it's not valide with two duplicate name for the same idea" do
    category = build(:category, name: "name", idea: idea1)
    expect(category).not_to be_valid
    expect(category.errors[:name]).to include("has already been taken")
  end
end
