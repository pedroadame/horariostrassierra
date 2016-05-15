class AddTeacherToGroup < ActiveRecord::Migration
  def change
    add_reference :groups, :teacher, index: true, foreign_key: true
  end
end
