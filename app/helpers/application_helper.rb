module ApplicationHelper
  # Returns full title on a per-page basis
  def full_title(title = '')
    base = 'Horarios Trassierra'
    return "#{title} | #{base}" unless title.empty?
    base
  end
end
