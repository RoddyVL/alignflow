class GenerateContentJob < ApplicationJob
  queue_as :default

  def perform(nich_id)
    # On récupère l'objet nich tout en gérant le cas ou il est nil
    nich = Nich.find_by(id: nich_id)
    return unless nich

    category = nich.ideas.find_by(status: 1).categories.find_by(status: 1)

    client = OpenAI::Client.new

  # instancier les modèles afin d'éviter une erreur 'id: nil' pour le turbo stream:
    avatar = nich.create_avatar
    offer = nich.create_offer
    message = nich.create_message
    script = nich.create_script
    result = nich.create_hypothesis_result

    # récupération de la donnée pour avatar
      avatar_prompt = PROMPTS[:avatar].gsub('%category', category.name)
      puts "avatar fetching AI"
      avatar_response = generate_text(client, avatar_prompt)
      puts "avatar_response: #{avatar_response}"

      parsed_avatar_response = JSON.parse(avatar_response)
      puts "update avatar"
        avatar.update(
          description: parsed_avatar_response['description'],
          information: parsed_avatar_response['information'],
          nich: nich)

        Turbo::StreamsChannel.broadcast_replace_to(
          "avatar_#{avatar.id}",
          target: "avatar_#{avatar.id}",
          partial: "avatars/avatar", locals: { avatar: avatar, category: category })


    # récupération de la donnée pour Offer
    unless offer == nil
      offer_prompt = PROMPTS[:offer].gsub('%category', category.name)
      puts "offer_prompt: #{offer_prompt}"

      puts "offer fetching AI"
      offer_response = generate_text(client, offer_prompt)
      puts "offer_response: #{offer_response}"

      puts "update offer"
        offer.update(
          answer: offer_response,
          nich: nich)

      puts "broadcassting offer"
      Turbo::StreamsChannel.broadcast_replace_to(
        "offer_#{offer.id}",
        target: "offer_#{offer.id}",
        partial: "offers/offer", locals: { offer: offer })
    end

    # récupération de la donnée pour Message
    message_prompt = PROMPTS[:message].gsub('%category', category.name)
    puts "message_prompt: #{message_prompt}"

      puts "message fetching AI"
      message_response = generate_text(client, message_prompt)
      puts "message_response: #{message_response}"

      puts "update message"
        message.update(
          answer: message_response,
          nich: nich)

      puts "broadcasting message"
      Turbo::StreamsChannel.broadcast_replace_to(
        "message_#{message.id}",
        target: "message_#{message.id}",
        partial: "messages/message", locals: { message: message })


   result_prompt = PROMPTS[:result].gsub('%category', category.name)
    puts "message_prompt: #{result_prompt}"
    puts "fetching Result AI"
      result_response = generate_text(client, result_prompt)
      puts "result_response: #{result_response}"

      puts "update result"
        result.update(
          answer: result_response,
          nich: nich)

      puts "broadcasting result"
      Turbo::StreamsChannel.broadcast_replace_to(
        "result_#{result.id}",
        target: "result_#{result.id}",
        partial: "hypothesis_results/result", locals: { result: result })

  #   puts "script fetching"
  #   script.update(question: generate_text(client, "en une phrase présente un business qui aide les personnes de cette niche: #{nich.name}"))
  #   Turbo::StreamsChannel.broadcast_replace_to(
  #     "message_#{script.id}",
  #     target: "script_#{script.id}",
  #     partial: "scripts/script", locals: { script: script })

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
