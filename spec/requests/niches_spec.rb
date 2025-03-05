require 'rails_helper'

RSpec.describe "Niches", type: :request do
  # instancie les variables que je vais utiliser dans mes 2 groupes describes
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let!(:nich1) { create(:nich, project: project) }
  let!(:nich2) { create(:nich, project: project) }

  before do
    sign_in user
  end


  describe "GET /niches" do
    before do
      get project_niches_path(project)
    end

    it "it should a successful response " do
      expect(response).to have_http_status(:success)
    end

    it "assigns @niches in INDEX action" do
      expect(assigns(:niches)).to match_array([nich1, nich2])
    end
  end


  describe "get /niches/:id" do
    before do
      get project_nich_path(project, nich1)
    end

    it "assign @niches for SHOW action" do
      expect(assigns(:niches)).to eq(Nich.where(project_id: project.id))
    end

    it "assign @ideas for SHOW action" do
      expect(assigns(:ideas)).to eq(nich1.ideas && nich2.ideas)
    end
  end


  describe "GET /niches/new" do
    before do
      get new_project_nich_path(project, nich1)
    end

    it "sould assign @nich for NEW action" do
      expect(assigns(:nich)).to be_a_new(Nich)
    end
  end


  describe "POST /niches" do
    let(:valid_attributes) { { nich: attributes_for(:nich) } }
    context "with valid attributes" do
      it "creates a new nich" do
        expect {
          post project_niches_path(project), params: valid_attributes
        }.to change(Nich, :count).by(1) # Vérifie qu'un nich est créé
      end
    end

    it "render the current page" do
      post project_niches_path(project), params: valid_attributes
      new_nich = Nich.last
      expect(response).to redirect_to(new_project_nich_path(project, new_nich))
    end

    it "sets a success notice" do
      post project_niches_path(project), params: valid_attributes
      follow_redirect! # Suit la redirection pour vérifier le message flash
      expect(flash[:notice]).to eq('Niche ajouter avec succès.') # Vérifie le message flash
    end
  end
end
