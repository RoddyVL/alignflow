class CreateAiResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_responses do |t|
      t.string :api_name
      t.text :ai_response
      t.references :nich, null: false, foreign_key: true

      t.timestamps
    end
  end
end
