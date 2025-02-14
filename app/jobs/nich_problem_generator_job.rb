class NichProblemGeneratorJob < ApplicationJob
  queue_as :default

  def perform(nich_id)
    nich = Nich.find_by(id: nich_id)
    return unless nich

    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])

    begin
      # Générer chaque réponse avec une requête séparée
      nich.update(ai_status: 1)

      problem_response = generate_response(client, "Quels sont les principaux problèmes rencontrés par les personnes dans cette niche ?", nich.name)
      fear_response = generate_response(client, "Quelles sont les plus grandes peurs des personnes dans cette niche ?", nich.name)
      desire_response = generate_response(client, "Quels sont les désirs et objectifs principaux des personnes dans cette niche ?", nich.name)

      # Mettre à jour la niche avec les résultats
      nich.update(problem: problem_response, fear: fear_response, desire: desire_response, ai_status: "completed")

    rescue => e
      Rails.logger.error("Erreur lors de la génération IA : #{e.message}")
      nich.update(ai_status: "error")
    end

    Turbo::StreamsChannel.broadcast_update_to(
      "nich_#{nich.id}",
      target: "nich_#{nich.id}",
      partial: "niches/details", locals: { nich: nich })
  end


  private

  def generate_response(client, prompt, nich_name)
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "system", content: "Tu es un expert en marketing." },
                   { role: "user", content: "#{prompt} La niche est : #{nich_name}." }],
        max_tokens: 200
      }
    )

    response.dig("choices", 0, "message", "content") || "Pas de réponse."
  end
end
