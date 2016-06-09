class ClassHour < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :group
  belongs_to :room
  belongs_to :subject
  belongs_to :hour

  validates :teacher, presence: true
  validates :group, presence: true
  validates :room, presence: true
  validates :subject, presence: true
  validates :hour, presence: true

  default_scope -> { }
  def groups
    grupos = [self.group.name]
    ClassHour.where(hour: self.hour, room: self.room, teacher: self.teacher,
                    subject: self.subject)
        .where.not(group: self.group)
        .each do |hora|
      grupos << hora.group.name
    end
    grupos
  end

  def in?(tramo)
    (self.hour.tramo_horario == tramo)
  end

  def now?
    self.hour == Hour.now
  end
end