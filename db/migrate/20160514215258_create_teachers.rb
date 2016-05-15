class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :abbreviation
      t.string :name
      t.string :level

      t.timestamps null: false
    end
  end
end
