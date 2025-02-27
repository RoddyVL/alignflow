class GenerateCategoriesJob < ApplicationJob
  queue_as :default

  def perform(idea)
    # récupérer l'Idea et sa description tout en gérant le cas ou il serait nil
    return unless idea

    # On créer les variables que l'on va passer à la méthode generate_text ici pour un code plus lisible
    client = OpenAI::Client.new
    prompt = "
    Ceci est un test, répond 'test'

    """

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
