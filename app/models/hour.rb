class Hour < ActiveRecord::Base
  # Formato de hora ##:## entre 00:00 y 23:59.
  HOUR_REGEX = /\A(([01][0-9])|(2[0-3])):[0-5][0-9]\z/
  PARSE_REGEX = /\A\s?([0-9]:[0-5][0-9])\z/

  validates :code, presence: true
  validates :day, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }
  validates :hour, numericality: {
      only_integer: true, greater_than: 0, less_than_or_equal_to: 14 }
  validates :start, format: { with: HOUR_REGEX }, presence: true
  validates :end, format: { with: HOUR_REGEX }, presence: true
  before_validation :parse_end_hour, :parse_start_hour

  has_many :class_hours

  class << self
    def search(params = {})

      if Rails.configuration.x.mock_time
        params[:day] ||= Time.mocked_now.wday
        hour = parse_hour(params[:hour]) || Time.mocked_now.strftime('%H:%M')
      else
        params[:day] ||= Time.now.wday
        hour = parse_hour(params[:hour]) || Time.now.strftime('%H:%M')
      end

      filter = self.arel_table[:day].eq(params[:day])
                   .and(self.arel_table[:start].lteq(hour)
                            .and(self.arel_table[:end].gt(hour)
                                     .or(self.arel_table[:end].eq('00:00'))))
      where(filter).first
    end

    def now
      search
    end

    def parse_hour(hour)
      if hour && (match = hour.match PARSE_REGEX)
        '0' << match[1]
      else
        hour
      end
    end

    def tramos_posibles
      horas = Hour.distinct.pluck(:start, :end)
      tramos = []
      horas.each do |k, v|
        tramos << (k + " - " + v)
      end
      tramos
    end
  end

  def tramo_horario

    self.start + " - " + self.end
  end

  private
  def parse_start_hour
    self.start = Hour.parse_hour(self.start)
  end

  def parse_end_hour
    self.end = Hour.parse_hour(self.end)
  end
end
