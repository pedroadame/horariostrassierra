class Group < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true

  # Relación con Profesor
  belongs_to :teacher
  has_many :class_hours
end
