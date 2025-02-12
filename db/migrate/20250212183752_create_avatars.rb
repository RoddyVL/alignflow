class CreateAvatars < ActiveRecord::Migration[7.1]
  def change
    create_table :avatars do |t|
      t.string :name
      t.text :descrition
      t.references :nich, null: false, foreign_key: true

      t.timestamps
    end
  end
end
