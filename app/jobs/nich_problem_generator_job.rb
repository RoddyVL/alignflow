class NichProblemGeneratorJob < ApplicationJob
  queue_as :default

  def perform(nich_id)
    # On récupère la nich tout en gérant le cas ou l'objet est nil
    nich = Nich.find_by(id: nich_id)
    return unless nich

    # On stock les 2 arguments que l'on va utiliser lors de l'appelle à la méthode 'generate_response' dans des variables pour un code plus lisible
    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
    prompt = """
    A partir de ce centre d'intérêt: '''#{nich.name}''', identifie 2 services en forte demande qui se vendent déjà et dont la croissance continue.
    Base-toi uniquement sur des **marchés en croissance** et des **services réellement vendus**.
    Ne génère **aucune idée aléatoire** ou hypothétique.

    Ne donne **aucune analyse, explication ou introduction**.
    Réponds uniquement avec **une liste formatée**, où chaque service est sur **une seule ligne** au format suivant :

    [Nom du service] : [Courte description]

    Utilise un retour à la ligne (\n) **uniquement** pour séparer chaque service.
    Ne mets **aucun saut de ligne** à l'ntérieur d'un service.
    Ne numérote pas la liste et n'ajoute aucun caractère supplémentaire (pas de tirets, ni de puces).

    **Exemple de réponse correcte :**
    Recommandation personnalisée : Algorithmes IA pour suggérer des produits ou contenus adaptés.\nDiagnostic médical assisté par IA : Outils pour aider les professionnels de santé à interpréter des données médicales.
    """

    #On passe le status à 1 pour indiquer que l'on démarre la requête
    nich.update(ai_status: 1)

    # envoyer une requête à l'IA et récupérer la réponse, puis la formater
    idea_description = generate_response(client, prompt)
    puts "création des idées"
    idea_description.split("\n").each do |idea|
      Idea.create(description: idea.strip, nich: nich) unless idea.strip.blank?
      puts "new idea created"
    end

    nich.update(ai_status: 2)
    ideas = nich.ideas
    puts "start broadcasting"
    Turbo::StreamsChannel.broadcast_replace_to(
      "nich_#{nich.id}",
      target: "nich_#{nich.id}",
      partial: "niches/details", locals: { nich: nich, project: nich.project, ideas: nich.ideas  })
    puts "finish broadcasting"
  end


  private


  def generate_response(client, prompt)
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: prompt}],
         max_tokens: 4000
      }
    )

    response.dig("choices", 0, "message", "content") || "Pas de réponse."
  end
end
