class GenerateContentJob < ApplicationJob
  queue_as :default

  def perform(nich_id)

    nich = Nich.find_by(id: nich_id)
    return unless nich

    client = OpenAI::Client.new

  # instancier les modèles afin d'éviter une erreur 'id: nil' pour le turbo stream:
    avatar = nich.create_avatar
    offer = nich.create_offer
    message = nich.create_message
    script = nich.create_script
    result = nich.create_hypothesis_result

    # les updates avec les données IA et récupérer en temps réelles avec turbo stream

    puts "avatar fetching AI"
    avatar.update(description: generate_text(client, "Décris un avatar pour #{nich.name} en 1 mot"))
    Turbo::StreamsChannel.broadcast_replace_to(
      "avatar_#{avatar.id}",
      target: "avatar_#{avatar.id}",
      partial: "avatars/avatar", locals: { avatar: avatar })

    puts "offer fetching AI"
    offer.update(answer: generate_text(client, "en 1 mot donne un nom d'offre pour cette nich: #{nich.name}"))
    Turbo::StreamsChannel.broadcast_replace_to(
      "offer_#{offer.id}",
      target: "offer_#{offer.id}",
      partial: "offers/offer", locals: { offer: offer })

    puts "message fetching AI"
    message.update(answer: generate_text(client, "définis en un mot le nom d'un business pour cette niche: #{nich.name}"))
    Turbo::StreamsChannel.broadcast_replace_to(
      "message_#{message.id}",
      target: "message_#{message.id}",
      partial: "messages/message", locals: { message: message })

    puts "script fetching"
    script.update(question: generate_text(client, "en une phrase présente un business qui aide les personnes de cette niche: #{nich.name}"))
    Turbo::StreamsChannel.broadcast_replace_to(
      "message_#{script.id}",
      target: "script_#{script.id}",
      partial: "scripts/script", locals: { script: script })

    puts "fetching Result AI"
    result.update(answer: generate_text(client, "en un mot défnis le résultats que veux attendre les personnes de cette niche: #{nich.name}") )
    Turbo::StreamsChannel.broadcast_replace_to(
      "result_#{result.id}",
      target: "result_#{result.id}",
      partial: "hypothesis_results/result", locals: { result:result })
    puts "broadcast done"
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
