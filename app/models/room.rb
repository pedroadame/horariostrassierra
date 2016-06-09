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
end
