# db/seeds.rb

# Suppression des anciennes données pour éviter les doublons lors du rechargement
# Cette étape permet de garantir que les données insérées dans la base sont fraîches et sans doublons
User.destroy_all
Project.destroy_all
Nich.destroy_all
Avatar.destroy_all
Offer.destroy_all
HypothesisResult.destroy_all
Message.destroy_all
Script.destroy_all
AiResponse.destroy_all

# Création d'un utilisateur. Cet utilisateur sera le propriétaire du projet.
user = User.create!(
  email: 'user@example.com',
  password: 'password123'
)
puts "Utilisateur #{user.email} créé."

# Création d'un projet pour cet utilisateur. Chaque utilisateur peut avoir plusieurs projets.
project = Project.create!(
  name: 'Mon premier projet',
  user: user
)
puts "Projet '#{project.name}' créé pour l'utilisateur #{user.email}."

# Création de niches pour le projet. Une niche représente un segment de marché spécifique.
nich1 = Nich.create!(
  name: 'Niche 1',
  problem: 'Problème 1 : Les utilisateurs ont des difficultés à comprendre les concepts fondamentaux.',
  fear: 'Peur 1 : La peur de ne jamais maîtriser le sujet et d\'être laissés pour compte.',
  desire: 'Désir 1 : Les utilisateurs veulent apprendre de manière plus intuitive et rapide.',
  status: Nich::UNSELECTED,
  project: project
)
puts "Niche '#{nich1.name}' créée dans le projet '#{project.name}'."

nich2 = Nich.create!(
  name: 'Niche 2',
  problem: 'Problème 2 : Les utilisateurs trouvent difficile de maintenir leur motivation à long terme.',
  fear: 'Peur 2 : La peur de ne pas être capable de maintenir un engagement constant.',
  desire: 'Désir 2 : Les utilisateurs souhaitent un programme qui les aide à rester motivés sur le long terme.',
  status: Nich::SELECTED,
  project: project
)
puts "Niche '#{nich2.name}' créée dans le projet '#{project.name}'."

# Création d'avatars pour les niches. Un avatar représente un profil type d'utilisateur dans une niche donnée.
Avatar.create!(
  name: 'Avatar Niche 1',
  description: "Cet avatar représente un utilisateur de la Niche 1. Il cherche à comprendre les concepts de manière plus profonde.",
  nich: nich1
)
puts "Avatar pour '#{nich1.name}' créé."

Avatar.create!(
  name: 'Avatar Niche 2',
  description: 'Cet avatar représente un utilisateur de la Niche 2. Il cherche à surmonter ses peurs et à maintenir une motivation élevée.',
  nich: nich2
)
puts "Avatar pour '#{nich2.name}' créé."

# Création d'offres pour les niches. Les offres sont des questions ouvertes pour comprendre les besoins des utilisateurs.
Offer.create!(
  question: 'Quel est votre plus grand défi dans l\'apprentissage de nouveaux concepts ?',
  answer: 'Réponse à l\'offre pour Niche 1 : La difficulté à relier les nouvelles informations à celles déjà acquises.',
  nich: nich1
)
puts "Offre pour '#{nich1.name}' créée."

Offer.create!(
  question: 'Quel est le principal obstacle à votre motivation ?',
  answer: 'Réponse à l\'offre pour Niche 2 : Le manque de soutien et d\'encouragement à long terme.',
  nich: nich2
)
puts "Offre pour '#{nich2.name}' créée."

# Création de résultats d'hypothèses pour les niches. Les résultats d'hypothèses permettent de tester des idées sur un segment spécifique.
HypothesisResult.create!(
  question: 'Quels résultats attendez-vous de ce programme d\'apprentissage ?',
  answer: 'Réponse aux résultats d\'hypothèses pour Niche 1 : Une meilleure compréhension des concepts fondamentaux et une capacité accrue à les appliquer.',
  nich: nich1
)
puts "HypothesisResult pour '#{nich1.name}' créé."

HypothesisResult.create!(
  question: 'Quel impact pensez-vous que ces résultats auront sur votre vie ?',
  answer: 'Réponse aux résultats d\'hypothèses pour Niche 2 : Ils me permettront de rester motivé et d\'atteindre mes objectifs à long terme.',
  nich: nich2
)
puts "HypothesisResult pour '#{nich2.name}' créé."

# Création de messages pour les niches. Les messages sont utilisés pour communiquer des valeurs ou des informations clés.
Message.create!(
  question: 'Quel est le message clé de votre entreprise pour cette niche ?',
  answer: 'Message clé pour Niche 1 : Apprenez à comprendre, non à mémoriser.',
  nich: nich1
)
puts "Message pour '#{nich1.name}' créé."

Message.create!(
  question: 'Comment voulez-vous que votre entreprise soit perçue par les clients de cette niche ?',
  answer: 'Message clé pour Niche 2 : Un programme fiable qui vous accompagne dans votre parcours.',
  nich: nich2
)
puts "Message pour '#{nich2.name}' créé."

# Création de scripts pour les niches. Les scripts servent à guider les utilisateurs dans leurs démarches.
Script.create!(
  question: 'Avez-vous déjà essayé de résoudre ce problème d\'apprentissage par vous-même ?',
  nich: nich1
)
puts "Script pour '#{nich1.name}' créé."

Script.create!(
  question: 'Pourquoi n\'avez-vous pas encore trouvé de solution efficace pour maintenir votre motivation ?',
  nich: nich2
)
puts "Script pour '#{nich2.name}' créé."

# Création de réponses AI pour les niches. Les réponses AI peuvent aider à comprendre les besoins spécifiques des niches en utilisant des outils d'IA.
AiResponse.create!(
  api_name: 'OpenAI',
  ai_response: { "message" => "Réponse d'OpenAI pour Niche 1 : Nous recommandons une méthode basée sur des exemples concrets." }.to_json,
  nich: nich1
)
puts "AiResponse pour '#{nich1.name}' créée."

AiResponse.create!(
  api_name: 'Perplexity',
  ai_response: { "message" => "Réponse de Perplexity pour Niche 2 : Un programme de soutien personnalisé pourrait augmenter la motivation." }.to_json,
  nich: nich2
)
puts "AiResponse pour '#{nich2.name}' créée."

puts "Toutes les données seed ont été créées avec succès !"
