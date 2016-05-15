class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :abbreviation
      t.string :name
      t.string :level
      t.string :code

      t.timestamps null: false
    end
  end
end
