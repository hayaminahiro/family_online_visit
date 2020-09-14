class UsersController < ApplicationController

  before_action :set_user, only: [:room_word_update, :edit, :update, :destroy, :video_room]
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, except: [:room_word_update, :index, :video_room, :edit, :update, :destroy]
  before_action :authenticate_facility!, only: [:room_word_update, :index, :video_room, :edit, :update, :destroy]

  def index
    @facility = Facility.find(params[:facility_id])
    @users = @facility.users.paginate(page: params[:page], per_page: 30).order(:id)
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
    redirect_to facility_users_url(current_facility)
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
    @facility = Facility.find(params[:facility_id])
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

  def facilities_used # 利用施設登録ページ
    @facilities = Facility.all.where.not(admin: true)
    @user = User.find(params[:user_id])
    if params[:search].present?
      @facilities = @facilities.where('facility_name LIKE ?', "%#{params[:search]}%")
    else
      @facilities = @facilities = @facilities.where('facility_name LIKE ?', "")
    end
  end

  def update_facilities_used
    @user = User.find(params[:user_id])
    @user.update_attributes(facilities_used_params)
    flash[:notice] = "登録施設を更新しました。"
    redirect_to user_facilities_used_url
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

      def facilities_used_params
        params.require(:user).permit(facility_ids: [])
      end

end
