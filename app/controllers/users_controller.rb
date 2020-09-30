class UsersController < ApplicationController
  before_action :set_user, only: [:room_word_update, :edit, :update, :destroy, :video_room]
  before_action :set_facility_id, only: [:index, :video_room]
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, except: [:room_word_update, :index, :video_room, :edit, :update, :destroy]
  before_action :authenticate_facility!, only: [:room_word_update, :index, :video_room, :edit, :update, :destroy]

  def index
    @users = @facility.users.paginate(page: params[:page], per_page: 30).order(:id)
    if params[:search].present?
      @users = @users.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id)
    end
  end

  def room_word_update
    if @user.update_attributes(room_params)
      flash[:notice] = "Room Nameを登録しました。"
    else
      flash[:alert] = "登録できませんでした。"
    end
    redirect_to facility_users_url(current_facility)
  end

  def show
    @facilities = Facility.all.where.not(admin: true)
    @facilities = @facilities.where(id: current_user.facilities)
    @informations = Information.where(facility_id: current_user.facilities).where(status: "others")
    @requests = RequestResident.where(user_id: current_user) #申請履歴
  end

  def edit
  end

  def update
    # passwordが空白でも編集できる
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
      redirect_to facility_users_url(current_facility)
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "#{@user.name}を削除しました。"
    redirect_to facility_users_url(current_facility)
  end

  def video_room
  end

  def new_admin
    @user = User.new
  end

    private

      def admin_params
        params.permit(:floor_authority)
      end

      def room_params
        params.require(:user).permit(:room_name)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def set_facility_id
        @facility = Facility.find(params[:facility_id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
end
