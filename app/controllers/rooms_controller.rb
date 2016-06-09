class RoomsController < ApplicationController
  def empties
    @rooms = Room.empties
  end
end
