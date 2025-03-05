require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should have_many(:niches) }
    it { should have_many(:skills) }
    it { should belong_to(:user) }


    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let!(:existing_project) { create(:project, name: "Unique Project", user: user1) }

    it "is valid with a unique name for the same user" do
      project = build(:project, name: "New Project", user: user1)
      expect(project).to be_valid
    end

    it "is not valid with a duplicate name for the same user" do
      project = build(:project, name: "Unique Project", user: user1)
      expect(project).not_to be_valid
      expect(project.errors[:name]).to include("has already been taken")
    end

    it "is valid with a duplicate name for a different user" do
      project = build(:project, name: "Unique Project", user: user2)
      expect(project).to be_valid
    end
  end
end
