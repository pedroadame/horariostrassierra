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

  def groups
    grupos = [self.group]
    ClassHour.where(hour: self.hour, room: self.room, teacher: self.teacher,
                    subject: self.subject)
        .where.not(group: self.group)
        .each do |hora|
      grupos << hora.group
    end
    grupos
  end
end