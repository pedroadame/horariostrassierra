module GroupsHelper
  def schedule_split_by_day(schedule)
    a = {}
    1.upto(5) { |i| a[i] = [] }
    schedule.each do |ch|
      a[ch.hour.day] << ch
    end
    a
  end
end
