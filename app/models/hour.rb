class Hour < ActiveRecord::Base
  # Formato de hora ##:## entre 00:00 y 23:59.
  HOUR_REGEX = /\A(([01][0-9])|(2[0-3])):[0-5][0-9]\z/
  PARSE_REGEX = /\A\s?([0-9]:[0-5][0-9])\z/

  validates :code, presence: true
  validates :day, numericality: {
      only_integer: true, greater_than: 0, less_than_or_equal_to: 5}
  validates :hour, numericality: {
      only_integer: true, greater_than: 0, less_than_or_equal_to: 14}
  validates :start, format: {with: HOUR_REGEX}, presence: true
  validates :end, format: {with: HOUR_REGEX}, presence: true
  before_validation :parse_end_hour, :parse_start_hour

  has_many :class_hours

  class << self
    def now(hora = nil)
      ahora = hora || Time.now.strftime('%H:%M')
      consulta = self.arel_table[:day].eq(Time.now.wday)
                     .and(self.arel_table[:start].lteq(ahora)
                              .and(self.arel_table[:end].gt(ahora)))
      where(consulta)
    end
  end

  private
  def parse_start_hour
    if (match = self.start.match PARSE_REGEX)
      self.start = '0' << match[1]
    end
  end

  def parse_end_hour
    if (match = self.end.match PARSE_REGEX)
      self.end = '0' << match[1]
    end
  end
end
