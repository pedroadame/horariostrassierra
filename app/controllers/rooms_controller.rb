class RoomsController < ApplicationController
  def empties
    @rooms = Room.empties
  end

  def schedule
    @room = Room.find params[:id]
  end

  def list
    @rooms = Room.where.not("abbreviation == ''").page(params[:page]).per_page(10)
  end
end
