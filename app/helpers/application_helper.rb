module ApplicationHelper
  # Returns full title on a per-page basis
  def full_title(title = '')
    base = 'Horarios Trassierra'
    return "#{title} | #{base}" unless title.empty?
    base
  end

  def schedule_split_by_day(schedule)
    a = {}
    1.upto(5) { |i| a[i] = [] }
    schedule.each do |ch|
      a[ch.hour.day] << ch
    end
    a
  end
end
