class AddStatusToIdea < ActiveRecord::Migration[7.1]
  def change
    add_column :ideas, :status, :integer, default: 0, null: false
  end
end
