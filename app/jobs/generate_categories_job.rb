class GenerateCategoriesJob < ApplicationJob
  queue_as :default

  def perform(idea)
    # récupérer l'Idea et sa description tout en gérant le cas ou il serait nil
    return unless idea

    # On créer les variables que l'on va passer à la méthode generate_text ici pour un code plus lisible
    client = OpenAI::Client.new
    prompt = """
    À partir de cette offre :
    ***#{idea.description}***

    Identifie 10 niches qui utilisent activement ce type de service, en te basant uniquement sur des données réelles et des usages concrets.

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

    categories_description = generate_categories(client, prompt)
    categories_description.split("\n").each do |category|
      Category.create(name: category, idea: idea) unless category.strip.blank?
  

    categories_description = generate_categories(client, prompt)
    categories_description.split("\n").each do |category|
      Category.create(name: category, idea: idea) unless category.strip.blank?
    end

    puts "start broadcasting"
    project = idea.nich.project
    Turbo::StreamsChannel.broadcast_append_to(
      "idea_#{idea.id}",
      target: "idea_#{idea.id}",
      partial: "category/categories", locals: { categories: idea.categories, idea: idea, project: project, nich: idea.nich })
    puts "finish broadcasting"
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
