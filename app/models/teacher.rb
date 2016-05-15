class Teacher < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true
  validates :level, presence: true

  # Relación con su tutoría.
  # Nos permite acceder a la tutoría del profesor (de tenerla)
  # de forma simple.
  has_one :group
end
