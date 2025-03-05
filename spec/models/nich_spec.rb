require 'rails_helper'

RSpec.describe Nich, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status)}
  it { should have_db_column(:status).of_type(:integer) }
  it { should have_db_column(:ai_status).of_type(:integer) }

  # pour cela je vais créer 2 projets différents
  let(:project1) { create(:project) }
  let(:project2) { create(:project) }

  # puis je vais tester le cas ou 1 projet à 2 noms de nich similaire dans quelle cas cela devra renvoyer un message d'erreur
  let!(:existing_nich) { create(:nich, name: "Nich", project: project1) }

  it "it's not valid with duplicate name within the same project" do
    nich = build(:nich, name: "Nich", project: project1)
    expect(nich).to be_invalid
    expect(nich.errors[:name]).to include("has already been taken")
  end

  it "it's valid with duplicate name for 2 differents project" do
    nich = build(:nich, name: "Nich", project: project2)
    expect(nich).to be_valid
  end

  it "should have a default status of 0" do
    nich = Nich.new
    expect(nich.status).to eq(0)
  end
end


# Je cherche à vérifier que un projet ne peut pas avoir
# 2 fois le même nom de nich
# Mais 2 projet différents peuvent avoir le même nom de nich
# Puis je vais tester le cas ou 2 projet on une Nich avec un nom similaire dans quelle cas cela devra renvoyer true
