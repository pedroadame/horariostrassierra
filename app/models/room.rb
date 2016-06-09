class Room < ActiveRecord::Base
  validates :name, presence: true
  has_many :class_hours, dependent: :destroy
  default_scope -> { order name: :asc }
  class << self
    def empties
      rooms = Room.all
      vacias = []
      rooms.each do |room|
        vacias << room if room.clase_actual.nil?
      end
      vacias
    end
  end

  def clase_actual(params = {})
    clases = self.class_hours.where(hour: Hour.search(day: params[:day],
                                                      hour: params[:hour]))
    clases.any? ? clases.first : nil
  end

  def schedule
    ids = ClassHour.find_by_sql(["SELECT max(class_hours.id) mid FROM class_hours INNER JOIN hours ON class_hours.hour_id = hours.id INNER JOIN rooms on class_hours.room_id = rooms.id WHERE class_hours.room_id = ? GROUP BY hours.id, rooms.id ORDER BY hours.day, hours.hour", self.id]).map {|x| x['mid']}
    horas_clase = []
    ids.each do |id|
      horas_clase << ClassHour.find(id)
    end
    horas_clase
  end
end
