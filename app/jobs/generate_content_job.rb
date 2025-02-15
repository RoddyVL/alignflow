class GenerateContentJob < ApplicationJob
  queue_as :default

  def perform(nich)
    @nich = nich
    client = OpenAI::Client.new

# Création ou mise à jour des modèles associés avec récupération immédiate

avatar = @nich.create_avatar!(description: generate_text(client, "Décris un avatar pour #{@nich.name}")) unless @nich.avatar
puts 'avatar created'
offer = @nich.create_offer!(answer: generate_text(client, "Crée une offre pour #{@nich.name}")) unless @nich.offer
puts 'offer created'
message = @nich.create_message!(answer: generate_text(client, "Quel message marketing utiliser pour #{@nich.name} ?")) unless @nich.message
puts 'message created'
script = @nich.create_script!(question: generate_text(client, "Rédige un script de vente pour #{@nich.name}")) unless @nich.script
puts 'script created'
result = @nich.create_hypothesis_result!(answer: generate_text(client, "Quel résultat le client obtient avec #{@nich.name} ?")) unless @nich.hypothesis_result
puts 'results created'


    # Rediriger vers la page du projet une fois terminé
    redirect_to project_path(@nich.project), notice: "Contenu généré avec succès!"
  end

  private

  def generate_text(client, prompt)
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "system", content: prompt }]
      }
    )
    response["choices"][0]["message"]["content"]
  end
end
