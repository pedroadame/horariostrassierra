class GroupsController < ApplicationController
  def schedule
    @group = Group.find params[:id]
  end

  def list
    @groups = Group.all
  end
end
