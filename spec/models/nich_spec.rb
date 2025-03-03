require 'rails_helper'

RSpec.describe Nich, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:nich) { create(:nich, project: project) }  # ✅ Pas besoin d'assigner user

  it "retrieves the correct user through project" do
    expect(nich.project.user).to eq(user) # ✅ Passe par `project`
  end

  it { should validate_presence_of(:name) }
end
