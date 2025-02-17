class NichProblemGeneratorJob < ApplicationJob
  queue_as :default

  def perform(nich_id)
    nich = Nich.find_by(id: nich_id)

    return unless nich

    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])

      # Générer chaque réponse avec une requête séparée
      nich.update(ai_status: 1)

      problem_response = generate_response(client, "En un mot décris le plus grand problème de cette niche", nich.name)
      fear_response = generate_response(client, "En un mot décris quelle est la plus grande peur des personnes dans cette niche ?", nich.name)
      desire_response = generate_response(client, "En un mot quels est le plus grand désir des personnes dans cette niche ?", nich.name)

      # Mettre à jour la niche avec les résultats
    nich.update(problem: problem_response, fear: fear_response, desire: desire_response, ai_status: "completed")
    puts 'NIIIIIIIIIIICHHHHHHEEEEE UPPPPPDDDDDDAAAAAAATTTTTTTEEEEEEDDDD 495498549599'
    puts 'STAAAAAAAAAAARRRRRRRRRRTTTTTTTTTT  BBBBBBBRRRRRRROOOOOOOOOOAAAAAAADDDCCCCCCCAAAAST495498549599'
    Turbo::StreamsChannel.broadcast_replace_to(
      "nich_#{nich.id}",
      target: "nich_#{nich.id}",
      partial: "niches/details", locals: { nich: nich, project: nich.project })
      puts 'update done in real time'
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
