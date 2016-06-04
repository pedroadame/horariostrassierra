module LangMenuHelper
  def lang_menu
    a = content_tag(:li, link("es"))
    a << content_tag(:li, link("en"))
  end

  private
    def lang
      I18n.locale.to_s
    end

    def link(locale)
      loc = (locale == "es" ? "Español" : "English")
      if locale == lang
        link_to(loc, url_for(locale: locale), class: 'idioma-actual')
      else
        link_to(loc, url_for(locale: locale))
      end
    end
end