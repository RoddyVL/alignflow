class ChangeDescritionToDescription < ActiveRecord::Migration[7.1]
  def change
    rename_column :avatars, :descrition, :description
  end
end
