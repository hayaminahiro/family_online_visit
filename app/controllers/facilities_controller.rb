class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[destroy correct_facility show facility_home]
  before_action :set_facility_id, only: :home
  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!, except: :home
  before_action :authenticate_user!, only: :home
  before_action :index_access_limits, only: :index

  def index
    return @facilities = Facility.where('facility_name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id) if params[:search].present?

    @facilities = Facility.where.not(admin: true).paginate(page: params[:page], per_page: 30).order(:id)
  end

  def home # 各施設のホーム画面
    @requests = current_user.request_residents.order(created_at: :desc).where(facility_id: @facility.id).first
  end

  def facility_home  # 施設ルートのhome画面
    @facilities = Facility.all.where.not(admin: true)
    @registration_application = @facilities.where(id: current_facility.users)
    @users = @facility.users.paginate(page: params[:page], per_page: 30).order(:id)
    @users = @users.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id) if params[:search].present?
    @info_top = Information.find_by(status: "head")
    @request_residents = RequestResident.where(req_approval: "申請中").where(facility_id: current_facility)
  end

  def destroy
    @facility.destroy
    redirect_to facilities_url, alert: "「#{@facility.facility_name}」の施設情報を削除しました。"
  end

  private

    def index_access_limits
      redirect_to :root and return until current_facility.admin?
    end

    def set_facility
      @facility = Facility.find(params[:id])
    end

    def set_facility_id
      @facility = Facility.find(params[:facility_id])
    end
end
