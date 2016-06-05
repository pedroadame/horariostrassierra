class Group < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true
  # Relación con Profesor
  belongs_to :teacher
  has_many :class_hours
  has_many :teachers, -> { distinct }, through: :class_hours
  def search(params = {})
    self.class_hours.where(hour: Hour.search(day: params[:day],
                                             hour: params[:hour])).first
  end

  def actual_teacher
    self.search&.teacher
  end
end
