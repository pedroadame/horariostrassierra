class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :abbreviation
      t.string :name
      t.string :level
      t.string :code
      t.string :course

      t.timestamps null: false
    end
  end
end
