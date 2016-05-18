class Teacher < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true

  # Relación con su tutoría.
  # Nos permite acceder a la tutoría del profesor (de tenerla)
  # de forma simple.
  has_one :group
  has_many :class_hours
  has_many :subjects, through: :class_hours

  def where_is(day = nil, hour = nil)
    self.class_hours.where(hour: Hour.search(day, hour))
  end

  def has_group?
    !self.group.nil?
  end

end
