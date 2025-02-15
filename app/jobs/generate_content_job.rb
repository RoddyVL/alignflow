class GenerateContentJob < ApplicationJob
  queue_as :default

  def perform(nich)
    @nich = nich
    client = OpenAI::Client.new

     # Création ou mise à jour des modèles associés avec récupération immédiate

avatar = @nich.create_avatar!(description: generate_text(client, "Décris un avatar pour #{@nich.name}")) unless @nich.avatar


offer = @nich.create_offer!(answer: generate_text(client, "Crée une offre pour #{@nich.name}")) unless @nich.offer


result = @nich.create_hypothesis_result!(answer: generate_text(client, "Quel résultat le client obtient avec #{@nich.name} ?")) unless @nich.result

message = @nich.create_message!(answer: generate_text(client, "Quel message marketing utiliser pour #{@nich.name} ?")) unless @nich.message


script = @nich.create_script!(question: generate_text(client, "Rédige un script de vente pour #{@nich.name}")) unless @nich.script
if script
  Turbo::StreamsChannel.broadcast_replace_to("script_#{script.id}", target: "script_#{script.id}", partial: "scripts/show", locals: { script: script })
end

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
