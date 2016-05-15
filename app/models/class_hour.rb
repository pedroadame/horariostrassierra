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
end
