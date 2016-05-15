class Subject < ActiveRecord::Base
  validates :abbreviation, presence: true
  validates :name, presence: true
  validates :level, presence: true
  validates :code, presence: true
  validates :course, presence: true
end
