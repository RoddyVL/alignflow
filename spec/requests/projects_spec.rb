require 'rails_helper' # Charge la configuration de RSpec pour Rails

RSpec.describe "Projects", type: :request do # Définit un groupe de tests pour les projets
  describe "GET /projects" do # Sous-groupe pour l'action index
    let(:user) { create(:user) } # Crée un utilisateur
    let!(:project1) { create(:project, user: user) } # Crée un projet associé à l'utilisateur
    let!(:project2) { create(:project, user: user) } # Crée un deuxième projet

    before do # Bloc exécuté avant chaque test
      sign_in user # Simule la connexion de l'utilisateur
      get projects_path # Envoie une requête GET à la page des projets
    end

    it "returns a successful response" do # Test 1 : Vérifie que la réponse est réussie
      expect(response).to have_http_status(:success) # Code HTTP 200
    end

    it "assigns @projects" do # Test 2 : Vérifie que @projects est correctement assigné
      expect(assigns(:projects)).to match_array([project1, project2]) # Contient les projets attendus
    end

    it "assigns @project" do # Test 3 : Vérifie que @project est une nouvelle instance
      expect(assigns(:project)).to be_a_new(Project) # Nouveau projet non sauvegardé
    end
  end
end
