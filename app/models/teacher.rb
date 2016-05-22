class Teacher < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true

  # Relación con su tutoría.
  # Nos permite acceder a la tutoría del profesor (de tenerla)
  # de forma simple.
  has_one :group
  has_many :class_hours

  class << self
    def in_guard
      ts = Teacher.all
      guardia = Subject.find_by_name "GUARDIA"
      ahora = Hour.now
      guardias = []
      ts.each do |t|
        guardias << t unless t.class_hours.where(hour: ahora, subject:
            guardia).count == 0
      end
      guardias
    end
  end

  def search(params = {})
    self.class_hours.where(hour: Hour.search(day: params[:day],
                                             hour: params[:hour])).first
  end

  def has_group?
    !self.group.nil?
  end
end
