class AddIdeaToNiches < ActiveRecord::Migration[7.1]
  def change
    add_column :niches, :idea, :string
  end
end
