class UsersController < ApplicationController

  before_action :set_user, only: [:room_word_update, :edit, :update]
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, except: [:index, :video_room, :edit, :update]
  before_action :authenticate_facility!, only: [:index, :video_room, :edit, :update]

  def index
    @users = User.where.not(admin: true).paginate(page: params[:page], per_page: 30).order(:id)
    if params[:search].present?
      @users = @users.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id)
    end
  end

  def room_word_update
    @user = User.find(params[:id])
    if @user.update_attributes(room_params)
      flash[:notice] = "Room Nameを登録しました。"
    else
      flash[:alert] = "登録できませんでした。"
    end
    redirect_to users_url
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
      redirect_to users_path
    else
      render "edit"
    end
  end

  def video_room
  end

  def change_admin
    @user = User.find(params[:id])
    if @user.update_attributes(admin_params)
      flash[:notice] = "権限を変更します"
      redirect_to root_path
    else
      flash[:alert] = "権限を変更できませんでした"
    end
    render :root
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

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
