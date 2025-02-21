class CreateIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :ideas do |t|
      t.string :description
      t.references :nich, null: false, foreign_key: true

      t.timestamps
    end
  end
end
