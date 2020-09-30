class FacilitiesController < ApplicationController

  before_action :set_facility, only: [:edit, :update, :destroy, :correct_facility, :show]
  before_action :set_facility_id, only: [:change_admin, :home]
  before_action :set_user_id, only: [:facilities_used, :my_facilities, :update_facilities_used]

  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!, except: [:home, :facilities_used, :my_facilities, :update_facilities_used, :new_connection, :create_connection]
  before_action :authenticate_user!, only: [:home, :facilities_used, :my_facilities, :update_facilities_used]

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
    else
      flash[:alert] = "更新できませんでした。入力内容をご確認ください。"
    end
    redirect_to facilities_url
  end

  def change_admin
    if @facility.update_attributes(admin_params)
      flash[:notice] = "権限を変更しました。"
    else
      flash[:alert] = "権限を変更できませんでした。"
    end
    redirect_to root_url
  end

  def destroy
    @facility.destroy
    flash[:notice] = "「#{@facility.facility_name}」の施設情報を削除しました。"
    redirect_to facilities_url
  end

  def home #各施設のホーム画面
    @requests = RequestResident.order(created_at: :desc).find_by(user_id: current_user.id)
  end

  def facilities_used # 利用施設検索/登録ページ
    @facilities = Facility.all.where.not(admin: true)
    if params[:search].present?
      @facilities = @facilities.where('facility_name LIKE ?', "%#{params[:search]}%").where.not(id: current_user.facilities).paginate(page: params[:page], per_page: 9).order(:id)
    else
      @facilities = @facilities.where('facility_name LIKE ?', "")
      # raise
    end
  end

  def my_facilities # 登録済み施設ページ
    @facilities = Facility.all.where.not(admin: true)
  end

  def update_facilities_used
    if (params[:user][:facility_ids] == [""]) == true
      @user.update_attributes(facilities_used_params)
      flash[:alert] = "新しく施設を登録して下さい。"
      redirect_to my_facilities_user_facilities_url
    else
      @user.update_attributes(facilities_used_params)
      flash[:notice] = "登録施設を更新しました。"
      redirect_to my_facilities_user_facilities_url
    end
  end

  def new_connection #申請された情報で入居者と家族を紐付ける画面
    current_facility.request_residents.each do |request|
    request_user = User.find(request.user_id)
      @residents = Resident.where(facility_id: current_facility)
      if params[:search].present?
        @residents = @residents.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 9).order(:id)
      else
        @residents = @residents.where('name LIKE ?', "")
      end
    end
  end

  def create_connection #入居者とご家族を紐付ける
    @user = User.find(params[:user_id].to_i)
    @request_resident = RequestResident.order(created_at: :desc).find_by(user_id: params[:user_id].to_i)
    if (params[:user][:resident_ids] == [""]) == true
      @user.update_attributes(residents_connection_params)
      flash[:alert] = "登録する入居者を選択してください。"
      redirect_to facility_url(params[:facility_id].to_i)
    else
      @user.update_attributes(residents_connection_params)
      flash[:notice] = "入居者登録しました。"
      redirect_to facility_url(params[:facility_id].to_i)
      @request_resident.登録済!
    end
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
        params.permit(:facility_admin)
      end

      def facilities_used_params
        params.require(:user).permit(facility_ids: [])
      end

      def residents_connection_params
        params.require(:user).permit(resident_ids: [])
      end
end
