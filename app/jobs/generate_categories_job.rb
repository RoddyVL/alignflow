class GenerateCategoriesJob < ApplicationJob
  queue_as :default

  def perform(idea)
    puts "start backgroundjob"
    # récupérer l'Idea et sa description tout en gérant le cas ou il serait nil
    return unless idea

    # On créer les variables que l'on va passer à la méthode generate_text ici pour un code plus lisible
    client = OpenAI::Client.new
    prompt = "À partir de cette offre :
    '''#{idea.description}'''

    Identifie 2 niches qui utilisent activement ce type de service, en te basant uniquement sur des données réelles et des usages concrets.

    Format de réponse obligatoire :
    Ne donne aucune analyse, explication ou introduction.

    Réponds uniquement avec une liste formatée, où chaque niche est sur une seule ligne sous ce format :

    [courte description]

    Utilise un retour à la ligne (\n) uniquement pour séparer chaque niche.

    Ne mets aucun saut de ligne à l'intérieur d'une niche.

    Ne numérote pas la liste et n'ajoute aucun caractère supplémentaire (pas de tirets, ni de puces).

    Exemple de réponse correcte :
    avocats qui veulent automatiser la création de contrat\nagences immobilières qui veulent automatiser la recherche de biens\nPME qui veulent automatiser la gestion des factures
    """

    puts "requête à l'API"
    categories_description = generate_categories(client, prompt)
    puts "réponse récupérer #{categories_description}"
    puts "créations des categories"
    categories_description.split("\n").each do |category|
      Category.create(name: category, idea: idea) unless category.strip.blank?
    end
    puts "categories created"
    puts "the GenerateCategoriesJob have been executed for #{idea_id}"
  end

    private

    def generate_categories(client, prompt)
      response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: [{ role: "system", content: prompt }]
        }
      )
      response["choices"][0]["message"]["content"]
    end
end
