class SearchsController < ApplicationController
  # noinspection RailsChecklist01
  def search
    @result = {teachers: [], rooms: [], groups: []}
    @param = ''
    if params[:q] && !params[:q].blank?
      @result = {teachers: [], rooms: [], groups: []}
      @result[:teachers] = Teacher.search(params[:q])
      @result[:rooms] = Room.search(params[:q])
      @result[:groups] = Group.search(params[:q])
      @param = params[:q]
    end
  end
end
