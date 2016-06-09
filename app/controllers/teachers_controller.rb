class TeachersController < ApplicationController

  def guards
    @teachers = Teacher.in_guard
  end

  def current_user_schedule
    if current_user.admin?
      redirect_to teacher_list_path
    else
      @teacher = current_user&.teacher
      render 'weekly_schedule'
    end
  end

  def schedule
    @teacher = Teacher.find params[:id]

    render 'weekly_schedule'
  end

  def teachers
    @teachers = Teacher.all
  end
end
