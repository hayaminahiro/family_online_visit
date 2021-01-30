class RelativesController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit]
  before_action :set_residents, except: %i[destroy index]
  before_action :set_active_requests, except: %i[new confirm destroy index]
  before_action :denial, only: :update

  # 申請一覧
  def new
    if params[:update_relatives].present?
      hash = {}
      update_relatives_params.each do |id, item|
        hash[RequestResident.where(facility_id: current_facility).where(req_approval: "request").find_by(user_id: id)] = item
      end
      @requests = hash
    else
      @requests = RequestResident.active(current_facility)
    end
  end

  # 確認画面
  def confirm
    @request_residents = confirm_params
  end

  # 一括で承認
  def update_relatives
    update_relatives_params.each do |id, update_ids|
      request_user = User.find(id)
      request = RequestResident.changer(current_facility, id)
      new_resident_ids = update_ids[:resident_ids].concat(update_ids[:set_ids])
      update_ids.delete(:set_ids)

      unless new_resident_ids.map(&:to_i).reject(&:zero?).sort == request_user.resident_ids.sort
        request_user.update_attributes(update_ids)
        request.approval!
      end
    end
    redirect_to facility_home_facility_url(current_facility), notice: "まとめて承認しました。"
  end

  # 個別に承認・否認
  def update
    @user = User.find(params[:user_id].to_i)
    @user.attributes = update_params
    if @user.save(context: :relative_update)
      request = RequestResident.changer(current_facility, params[:user_id].to_i)
      request.approval!
      redirect_to facility_home_facility_url(current_facility), notice: "登録申請を承認しました。"
    else
      params[:commit] == "承認済に変更" ? (render :edit) : (render :show)
    end
  end

  # 承認済み申請一覧
  def index
    @applied_ids = RequestResident.search(params[:search], current_facility)
  end

  def show; end

  def edit; end

  def destroy; end

  private

    def confirm_params
      params.require(:facility).permit(request_residents: [resident_ids: [], set_ids: []])[:request_residents]
    end

    def update_relatives_params
      permited_hash = {}
      params.require(:update_relatives).each_pair do |id, value|
        permited_hash[id] = value.permit(resident_ids: [], set_ids: [])
      end
      permited_hash
    end

    def update_params
      params.require(:user).permit(resident_ids: [])
    end

    def set_request
      @request = RequestResident.find(params[:id])
    end

    def set_user
      @user = User.find(@request.user_id)
    end

    def set_residents
      @residents = Relative.search(params[:search], current_facility)
    end

    def set_active_requests
      @requests = RequestResident.active(current_facility)
    end

    def denial
      return if params[:denial].blank?

      request = RequestResident.find(params[:denial])
      request.denial!
      RequestMailer.send_denial_to_user(current_facility, request).deliver
      redirect_to facility_home_facility_url(current_facility), notice: "#{request.user.name}様の申請を否認しました。"
    end
end
