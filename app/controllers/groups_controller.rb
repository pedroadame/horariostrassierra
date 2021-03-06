class GroupsController < ApplicationController
  def schedule
    @group = Group.find params[:id]
  end

  def list
    @groups = Group.where.not("abbreviation == 'GUARD'").page(params[:page]).per_page(10)
  end
end
