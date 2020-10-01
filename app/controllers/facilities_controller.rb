class FacilitiesController < ApplicationController

  before_action :set_facility, only: [:edit, :update, :destroy, :correct_facility, :show, :facility_home]
  before_action :set_facility_id, only: [:change_admin, :home]
  before_action :set_user_id, only: [:facilities_used, :update_facilities_used]

  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!, except: [:home, :facilities_used, :update_facilities_used]
  before_action :authenticate_user!, only: [:home, :facilities_used, :update_facilities_used]

  def index
    @facilities = Facility.where.not(admin: true).paginate(page: params[:page], per_page: 30).order(:id)
    if params[:search].present?
      @facilities = Facility.where('facility_name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id)
    end
  end

  def edit
  end

  def update
    # passwordが空白でも編集できる
    if params[:facility][:password].blank? && params[:facility][:password_confirmation].blank?
      params[:facility].delete(:password)
      params[:facility].delete(:password_confirmation)
    end
    if @facility.update_attributes(facility_params)
      flash[:notice] = "「#{@facility.facility_name}」の施設情報を更新できました。"
      redirect_to facilities_url
    else
      render :edit
    end
  end

  def facility_home  #施設ルートのhome画面
    @calendar_reservations = Reservation.where.not(calendar_day: nil)
    @users = @facility.users.paginate(page: params[:page], per_page: 30).order(:id)
    if params[:search].present?
      @users = @users.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id)
    end
  end

  def change_admin
    if @facility.update_attributes(admin_params)
      flash[:notice] = "権限を変更しました。"
    else
      flash[:alert] = "権限を変更できませんでした。"
    end
    redirect_to facility_home_facility_url @facility
  end

  def destroy
    @facility.destroy
    flash[:notice] = "「#{@facility.facility_name}」の施設情報を削除しました。"
    redirect_to facilities_url
  end

  def home #各施設のホーム画面
  end

  def facilities_used # 利用施設検索/登録ページ
    @facilities = Facility.all.where.not(admin: true)
    if params[:search].present?
      @facilities = @facilities.where('facility_name LIKE ?', "%#{params[:search]}%").where.not(id: current_user.facilities).paginate(page: params[:page], per_page: 12).order(:id)
    else
      @facilities = @facilities.where('facility_name LIKE ?', "")
    end
  end

  def update_facilities_used
    if params[:user].present?
      params[:user][:facility_ids].delete("0")
    end
    if params[:user].blank?
      flash[:alert] = "新しく施設を登録して下さい。"
    elsif params[:user][:facility_ids].map{|n| n.to_i}.sort == current_user.facilities.ids.sort
      flash[:alert] = "登録施設が更新されていません。登録チェック ✔️ を確認して更新して下さい。"
    elsif params[:user][:facility_ids].map{|n| n.to_i}.count > current_user.facilities.ids.count
      @user.update_attributes(facilities_used_params)
      flash[:notice] = "新しく施設を登録しました。"
    elsif params[:user][:facility_ids].map{|n| n.to_i}.count < current_user.facilities.ids.count
      @user.update_attributes(facilities_used_params)
      flash[:notice] = "登録施設を解除しました。"
    end
    redirect_to facilities_used_user_facilities_url
  end

    private

      def set_facility
        @facility = Facility.find(params[:id])
      end

      def set_facility_id
        @facility = Facility.find(params[:facility_id])
      end

      def set_user_id
        @user = User.find(params[:user_id])
      end

      def facility_params
        params.require(:facility).permit(:facility_name, :email, :password,:password_confirmation)
      end

      def admin_params
        params.require(:facility).permit(:facility_admin)
      end

      def facilities_used_params
        params[:user][:facility_ids].delete("0")
        params.require(:user).permit(facility_ids: [])
      end

end
