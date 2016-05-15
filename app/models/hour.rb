class Hour < ActiveRecord::Base
  validates :code, presence: true
  validates :day, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
  validates :hour, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 14 }

  # Formato de hora ##:## entre 00:00 y 23:59.
  HOUR_REGEX = /(([01][0-9])|(2[0-3])):[0-5][0-9]/

  validates :start, format: { with: HOUR_REGEX }, presence: true
  validates :end, format: { with: HOUR_REGEX }, presence: true
end
