class InstatiateNichAssociatedModelJob < ApplicationJob
  queue_as :default

  def perform(nich_id)
    nich = nich.find_by(id: nich_id)
    return unless nich

    create_avatar unless avatar
    create_offer unless offer
    create_hypothesis_result unless hypothesis_result
    create_message unless message
    create_script unless script
  end
end
