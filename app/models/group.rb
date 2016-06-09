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

  def schedule
    ids = ClassHour.find_by_sql(["SELECT max(class_hours.id) mid FROM class_hours INNER JOIN hours ON class_hours.hour_id = hours.id INNER JOIN rooms on class_hours.room_id = rooms.id WHERE class_hours.group_id = ? GROUP BY hours.id, rooms.id ORDER BY hours.day, hours.hour", self.id]).map {|x| x['mid']}
    horas_clase = []
    ids.each do |id|
      horas_clase << ClassHour.find(id)
    end
    horas_clase
  end
end
