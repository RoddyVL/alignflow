class ChangeStatusDefaultInNichs < ActiveRecord::Migration[7.1]
  def change
    change_column_default :niches, :status, 0
    change_column_null :niches, :status, false
  end
end
