module DrawerHelper
  include UsersHelper

  def drawer_header
    header = gravatar_for current_user, { size: 100}
    data = content_tag :div do
      a = content_tag :h6, gravatar_name, class: 'ellipsizable'
      b = content_tag :span, current_user.email, class: 'ellipsizable'
      a + b
    end
    header + data
  end

  def should_render_drawer
    user_signed_in? && (!current_user.teacher.nil? || current_user.admin?)
  end
end