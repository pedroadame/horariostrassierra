class RoomsController < ApplicationController
  def empties
    @rooms = Room.empties
  end

  def schedule
    @room = Room.find params[:id]
  end

  def list
    @rooms = Room.all
  end
end
