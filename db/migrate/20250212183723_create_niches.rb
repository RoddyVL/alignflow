class CreateNiches < ActiveRecord::Migration[7.1]
  def change
    create_table :niches do |t|
      t.string :name
      t.text :problem
      t.text :fear
      t.text :desire
      t.integer :status
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
