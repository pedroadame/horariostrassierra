class Teacher < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true

  # Relación con su tutoría.
  # Nos permite acceder a la tutoría del profesor (de tenerla)
  # de forma simple.
  has_one :group
  has_many :class_hours

  def search(params = {})
    self.class_hours.where(hour: Hour.search(day: params[:day],
                                             hour: params[:hour])).first
  end

  def has_group?
    !self.group.nil?
  end

end
