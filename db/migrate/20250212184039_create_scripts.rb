class CreateScripts < ActiveRecord::Migration[7.1]
  def change
    create_table :scripts do |t|
      t.text :question
      t.references :nich, null: false, foreign_key: true

      t.timestamps
    end
  end
end
