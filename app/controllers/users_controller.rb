class UsersController < ApplicationController
  def profile
    redirect_to edit_user_registration_url
  end
end