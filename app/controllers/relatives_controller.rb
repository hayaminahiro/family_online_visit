class RelativesController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit]
  before_action :set_residents, except: %i[confirm destroy index]
  before_action :denial, only: :update

  # 家族から申請された内容を確認
  def new; end

  # 家族からの申請を承認・否認
  def update
    @user = User.find(params[:user_id].to_i)
    @user.attributes = connection_params
    if @user.save(context: :relative_update)
      request_resident = RequestResident.changer(current_facility, params[:user_id].to_i)
      request_resident.approval!
      redirect_to facility_home_facility_url(current_facility), notice: "登録申請を承認しました。"
    else
      params[:commit] == "承認済に変更" ? (render :edit) : (render :show)
    end
  end

  def confirm
    @request_residents = acceptance_params
    @residents = Relative.search(params[:search], current_facility)
  end

  def update_relatives
    residents_connection_params.each do |id, item|
      request_user = User.find(id)
      req_resident = RequestResident.changer(current_facility, id)
      unless item[:resident_ids].map(&:to_i).reject(&:zero?).count == request_user.resident_ids.count
        req_resident.approval!
        request_user.update_attributes(item)
      end
    end
    redirect_to facility_home_facility_url(current_facility), notice: "まとめて承認しました。"
  end

  # 承認済み申請一覧
  def index
    @applied_ids = RequestResident.search(params[:search], current_facility)
  end

  def show; end

  # status/紐付けの変更
  def edit; end

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

    def set_user
      @user = User.find(@request.user_id)
    end

    def set_request
      @request = RequestResident.find(params[:id])
    end

    def set_residents
      @requests = RequestResident.active(current_facility)
      @residents = Relative.search(params[:search], current_facility)
    end

    def denial
      return if params[:denial].blank?

      request = RequestResident.find(params[:denial])
      # enumの値を「申請中→否認済」に更新
      request.denial!
      RequestMailer.send_denial_to_user(current_facility, request).deliver
      redirect_to facility_home_facility_url(current_facility), notice: "#{request.user.name}様の申請を否認しました。"
    end
end
