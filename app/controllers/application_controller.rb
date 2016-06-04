# Clase ApplicationController.
# Provee de funcionalidad adicional a todos los controladores.
class ApplicationController < ActionController::Base
  # Previene ataques CSRF
  protect_from_forgery with: :exception
  before_action { authenticate_user! && has_teacher! }
  before_action :selected_teacher!, only: [:select_teacher, :assign_teacher]

  def index
  end

  def select_teacher
    @teachers = Teacher.wo_account
  end

  def assign_teacher
    user = current_user
    user.teacher = Teacher.find_by_id params[:id]
    user.save!
    redirect_to root_url
  end


  private
    def has_teacher!
      if current_user&.teacher.nil? && action_name != "select_teacher" &&
          action_name != "assign_teacher"
        redirect_to select_teacher_url
      end
    end

    def selected_teacher!
      redirect_to root_url unless current_user.teacher.nil?
    end
end
