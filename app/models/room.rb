class Room < ActiveRecord::Base
  validates :name, presence: true
  has_many :class_hours
end
