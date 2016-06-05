class TeachersController < ApplicationController

  def guards
    @teachers = Teacher.in_guard
  end
end
