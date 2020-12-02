class RoomsController < ApplicationController
  before_action :set_room, only: %i[craate edit update]

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

    def set_room
      @room = Room.find(params[:id])
    end
end
