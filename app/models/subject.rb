class Subject < ActiveRecord::Base
  validates :abbreviation, presence: true
  validates :name, presence: true
  validates :level, presence: true
  has_many :class_hours
end
