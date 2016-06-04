module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert-error">
      #{I18n.translate "errores"}
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end