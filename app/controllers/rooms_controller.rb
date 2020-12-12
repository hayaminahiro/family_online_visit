class RoomsController < ApplicationController
  before_action :set_room, only: %i[edit update]
  before_action :set_user, only: %i[new create edit update]

  def new
    @room = Room.new
  end

  def create
    @room = @user.rooms.build(room_params)
    if @room.save
      redirect_to users_url, notice: "Room Nameを登録しました。"
    else
      render :new
    end
  end

  def edit
    @room = @user.rooms.find_by(id: params[:id])
  end

  def update
    @room = @user.rooms.find_by(id: params[:id])
    if @room.update_attributes(room_params)
      redirect_to users_url, notice: "Room Nameを更新しました。"
    else
      render :edit
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :facility_id)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
