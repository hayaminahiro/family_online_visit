class FacilitiesController < ApplicationController

  before_action :set_facility, only: [:edit, :update, :destroy, :correct_facility, :show, :facility_home]
  before_action :set_facility_id, only: [:change_admin, :home]
  before_action :set_user_id, only: [:facilities_used, :update_facilities_used]
  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!, except: [:home, :facilities_used, :update_facilities_used, :new_connection, :create_connection]
  before_action :authenticate_user!, only: [:home, :facilities_used, :update_facilities_used]
  before_action :index_access_limits, only: :index

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
      redirect_to @facility
    else
      render :edit
    end
  end

  def facility_home  #施設ルートのhome画面
    @facilities = Facility.all.where.not(admin: true)
    @registration_application = @facilities.where(id: current_facility.users)
    @users = @facility.users.paginate(page: params[:page], per_page: 30).order(:id)
    if params[:search].present?
      @users = @users.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id)
    end
    @info_top = Information.find_by(status: "head")
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
    # RequestResidentを新しく作成された順に並べ替え、今いる施設のidの範囲にレコードを指定し、ログイン中の自分のidに最初にヒットした１つのレコードを取得
    @requests = RequestResident.order(created_at: :desc).where(facility_id: @facility.id).find_by(user_id: current_user.id)
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

  def new_connection #申請された情報で入居者と家族を紐付ける画面
    @residents = Resident.where(facility_id: current_facility)
    if params[:search].present?
      @residents = @residents.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 9).order(:id)
    else
      @residents = @residents.where('name LIKE ?', "")
    end
  end

  def create_connection #入居者とご家族を紐付ける
    @user = User.find(params[:user_id].to_i)
    @request_resident = RequestResident.order(created_at: :desc).find_by(user_id: params[:user_id].to_i)
    if (params[:user][:resident_ids] == ["", ""]) == true
      @user.update_attributes(residents_connection_params)
      flash[:alert] = "登録する入居者を選択してください。"
      redirect_to facility_url(params[:facility_id].to_i)
    else
      @user.update_attributes(residents_connection_params)
      flash[:notice] = "入居者登録しました。"
      redirect_to facility_url(params[:facility_id].to_i)
      @request_resident.登録済! #この記述で@request_residentのenumの値を「申請中→登録済」に更新させている
    end
  end

    private

      def index_access_limits
        until current_facility.admin?
          redirect_to :root and return
        end
      end

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
        params.require(:facility).permit(:image, :facility_name, :email, :password,:password_confirmation)
      end

      def admin_params
        params.require(:facility).permit(:facility_admin)
      end

      def facilities_used_params
        params[:user][:facility_ids].delete("0")
        params.require(:user).permit(facility_ids: [])
      end

      def residents_connection_params
        params.require(:user).permit(resident_ids: [])
      end
end
