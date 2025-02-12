# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Suppression des anciennes données pour éviter les doublons lors du rechargement
User.destroy_all
Project.destroy_all
Nich.destroy_all
Avatar.destroy_all
Offer.destroy_all
HypothesisResult.destroy_all
Message.destroy_all
Script.destroy_all
AiResponse.destroy_all

# Création d'un utilisateur
user = User.create!(
  email: 'user@example.com',
  password: 'password123'
)

# Création d'un projet pour cet utilisateur
project = Project.create!(
  name: 'Mon premier projet',
  user: user
)

# Création de niches pour le projet
nich1 = Nich.create!(
  name: 'Niche 1',
  problem: 'Problème 1',
  fear: 'Peur 1',
  desire: 'Désir 1',
  status: Nich::UNSELECTED,
  project: project
)

nich2 = Nich.create!(
  name: 'Niche 2',
  problem: 'Problème 2',
  fear: 'Peur 2',
  desire: 'Désir 2',
  status: Nich::SELECTED,
  project: project
)

# Création d'avatars pour les niches
Avatar.create!(
  name: 'Avatar Niche 1',
  description: "Description de l'avatar pour la niche 1",
  nich: nich1
)

Avatar.create!(
  name: 'Avatar Niche 2',
  description: 'Description de l\'avatar pour la niche 2',
  nich: nich2
)

# Création d'offres pour les niches
Offer.create!(
  question: 'Quel est votre plus grand défi ?',
  answer: 'Réponse à l\'offre pour Niche 1',
  nich: nich1
)

Offer.create!(
  question: 'Quel est le principal problème de votre secteur ?',
  answer: 'Réponse à l\'offre pour Niche 2',
  nich: nich2
)

# Création de résultats d'hypothèses pour les niches
HypothesisResult.create!(
  question: 'Quels résultats attendez-vous ?',
  answer: 'Réponse aux résultats d\'hypothèses pour Niche 1',
  nich: nich1
)

HypothesisResult.create!(
  question: 'Quel impact ces résultats auront-ils ?',
  answer: 'Réponse aux résultats d\'hypothèses pour Niche 2',
  nich: nich2
)

# Création de messages pour les niches
Message.create!(
  question: 'Quel est le message clé de votre entreprise ?',
  answer: 'Message clé pour Niche 1',
  nich: nich1
)

Message.create!(
  question: 'Comment voulez-vous être perçu par vos clients ?',
  answer: 'Message clé pour Niche 2',
  nich: nich2
)

# Création de scripts pour les niches
Script.create!(
  question: 'Avez-vous déjà essayé de résoudre ce problème ?',
  nich: nich1
)

Script.create!(
  question: 'Pourquoi n\'avez-vous pas encore résolu ce problème ?',
  nich: nich2
)

# Création de réponses AI pour les niches
AiResponse.create!(
  api_name: 'OpenAI',
  ai_response: { "message" => "Réponse d'OpenAI pour Niche 1" }.to_json,
  nich: nich1
)

AiResponse.create!(
  api_name: 'Perplexity',
  ai_response: { "message" => "Réponse de Perplexity pour Niche 2" }.to_json,
  nich: nich2
)

puts "Seed data successfully created!"
