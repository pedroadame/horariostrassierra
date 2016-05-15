class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.string :code
      t.integer :day
      t.integer :hour
      t.string :start
      t.string :end

      t.timestamps null: false
    end
  end
end
