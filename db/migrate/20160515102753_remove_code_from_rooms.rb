class RemoveCodeFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :code
  end
end
