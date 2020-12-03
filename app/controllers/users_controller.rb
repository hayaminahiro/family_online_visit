class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy video_room]
  # before_action :set_facility_id, only: %i[index video_room]
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, except: %i[index video_room edit update destroy]
  before_action :authenticate_facility!, only: %i[index video_room edit update destroy]

  def index
    @users = User.search(params[:search], current_facility).paginate(page: params[:page], per_page: 30)
  end

  def show
    @informations = Information.where(facility_id: current_user.facilities).where(status: "others")
  end

  def edit; end

  def update
    # passwordが空白でも編集できる
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(user_params)
      redirect_to users_url(current_facility), notice: "ユーザー情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url(current_facility), notice: "#{@user.name}を削除しました。"
  end

  def video_room
    @room = Room.find_by(user_id: @user.id, facility_id: current_facility.id)
  end

  def new_admin
    @user = User.new
  end

  private

    def room_params
      params.require(:user).permit(:room_name)
    end

    def set_user
      @user = User.find(params[:id])
    end

    # def set_facility_id
    #   @facility = Facility.find(params[:facility_id])
    # end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
