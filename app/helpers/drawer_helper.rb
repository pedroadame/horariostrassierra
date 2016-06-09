module DrawerHelper
  include UsersHelper

  def drawer_header
    header = gravatar_for current_user, { size: 100 }
    data = content_tag :div do
      name = content_tag :h6, gravatar_name, class: 'ellipsizable'
      email = content_tag :span, current_user.email, class: 'ellipsizable'
      name + email
    end
    header + data
  end

  def should_render_drawer
    user_signed_in? && (!current_user.teacher.nil? || current_user.admin?)
  end
end