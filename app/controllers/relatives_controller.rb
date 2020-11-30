class RelativesController < ApplicationController
  before_action :set_request, only: %i[show update destroy]
  before_action :set_residents, only: %i[new show update update_relatives]
  before_action :denial, only: :update

  # 家族から申請された内容を確認
  def new; end

  # 家族からの申請を承認・否認
  def update
    @user = User.find(params[:user_id].to_i)
    @user.attributes = connection_params
    if @user.save(context: :relative_update)
      request_resident = RequestResident.order(created_at: :desc).find_by(user_id: params[:user_id].to_i)
      request_resident.承認済!
      redirect_to facility_home_facility_url(current_facility), notice: "入居者登録しました。"
    else
      render :show
    end
  end

  def confirm
    @requests = acceptance_params
    @residents = Relative.search(params[:search], current_facility)
  end

  def update_relatives
    residents_connection_params.each do |id, item|
      request_user = User.find(id)
      req_resident = RequestResident.order("id DESC").find_by(user_id: id)
      if item[:resident_ids].map(&:to_i).reject(&:zero?).count == request_user.resident_ids.count
        req_resident.否認済!
      else
        req_resident.承認済!
        request_user.update_attributes(item)
      end
    end
    redirect_to facility_home_facility_url(current_facility), notice: "まとめて承認しました。"
  end

  # 承認済み申請一覧
  def index
    @approvals = RequestResident.where.not(req_approval: "申請中").where(facility_id: current_facility)
  end

  def show
    @user = User.find(@request.user_id)
  end

  def destroy; end

  private

    def connection_params
      params.require(:user).permit(resident_ids: [])
    end

    def acceptance_params
      params.require(:facility).permit(request_residents: [resident_ids: []])[:request_residents]
    end

    def residents_connection_params
      params.require(:update_relatives).permit!
    end

    def set_request
      @request = RequestResident.find(params[:id])
    end

    def set_residents
      @requests = RequestResident.where(facility_id: current_facility).where(req_approval: "申請中")
      @residents = Relative.search(params[:search], current_facility)
    end

    def denial
      return if params[:denial].blank?

      request = RequestResident.find(params[:denial])
      # enumの値を「申請中→否認済」に更新
      request.否認済!
      redirect_to facility_home_facility_url(current_facility), notice: "[#{request.req_name}][#{request.req_phone}][#{request.req_address}]の申請を否認しました。"
    end
end
