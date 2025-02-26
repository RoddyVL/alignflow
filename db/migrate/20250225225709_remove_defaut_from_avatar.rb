class RemoveDefautFromAvatar < ActiveRecord::Migration[7.1]
  def change
    change_column_default :avatars, :information, nil
    change_column_default  :avatars, :description, nil
  end
end
