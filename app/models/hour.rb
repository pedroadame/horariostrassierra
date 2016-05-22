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
  validates :start, format: {with: HOUR_REGEX}, presence: true
  validates :end, format: {with: HOUR_REGEX}, presence: true
  before_validation :parse_end_hour, :parse_start_hour

  has_many :class_hours

  class << self
    def search(params = {})
      params[:day] ||= Time.now.wday
      hour = parse_hour(params[:hour]) || Time.now.strftime('%H:%M')
      filter = self.arel_table[:day].eq(params[:day])
                   .and(self.arel_table[:start].lteq(hour)
                            .and(self.arel_table[:end].gt(hour)))
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
  end


  private
  def parse_start_hour
    self.start = Hour.parse_hour(self.start)
  end

  def parse_end_hour
    self.end = Hour.parse_hour(self.end)
  end
end
