# Clase ApplicationController.
# Provee de funcionalidad adicional a todos los controladores.
require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Previene ataques CSRF
  protect_from_forgery with: :exception
  before_action(:except => [:set_locale]) { authenticate_user! && has_teacher! }
  before_action :selected_teacher!, only: [:select_teacher, :assign_teacher]
  before_action :set_locale

  def self.default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def index
  end

  def select_teacher
    if current_user.admin?
      flash[:notice] = "Solo los profesores pueden hacer eso"
      redirect_to root_url
    end
    @teachers = Teacher.wo_account.paginate(page: params[:page], per_page: 10)
  end

  def assign_teacher
    user = current_user
    user.teacher = Teacher.find_by_id params[:id]
    user.save!
    redirect_to root_url
  end

  private
    def has_teacher!
      if current_user&.teacher.nil? && !current_user.admin? && action_name != "select_teacher" &&
          action_name != "assign_teacher"
        redirect_to select_teacher_url
      end
    end

    def selected_teacher!
      redirect_to root_url unless current_user.teacher.nil?
    end

    def parse_referer(ref)
      return nil if ref.nil?
      regex = /\A(https?):\/\/(.*)\/(.*)\/(.*)\z/
      matches = ref.match regex
      matches = matches.to_a
      matches.shift
      matches[2] = tld_toggle(matches[2])
      m = matches[0]
      matches.shift
      "#{m}://#{matches.join("/")}"
    end

    def tld_toggle(tld)
      tld == "es" ? "en" : "es"
    end
end
