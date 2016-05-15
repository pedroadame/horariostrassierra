class CreateClassHours < ActiveRecord::Migration
  def change
    create_table :class_hours do |t|
      t.references :teacher, index: true, foreign_key: true, null: false
      t.references :group, index: true, foreign_key: true, null: false
      t.references :room, index: true, foreign_key: true, null: false
      t.references :subject, index: true, foreign_key: true, null: false
      t.references :hour, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
