class AddAiFieldsToNiches < ActiveRecord::Migration[7.1]
  def change
    add_column :niches, :ai_status, :integer, default: 0, null: false
    add_column :niches, :ai_last_updated_at, :datetime
  end
end
