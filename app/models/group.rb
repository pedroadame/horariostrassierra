class Group < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true
  validates :level, presence: true
  validates :code, presence: true
  validates :course, presence: true

  # Relación con Profesor
  belongs_to :teacher
end
