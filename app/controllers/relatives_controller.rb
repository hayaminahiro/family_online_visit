class RelativesController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit]
  before_action :set_residents, except: %i[destroy index]
  before_action :set_active_requests, except: %i[new confirm destroy index]

  # 申請一覧
  def new
    if params[:update_relatives].present?
      hash = {}
      update_relatives_params.each do |id, item|
        hash[RequestResident.where(facility_id: current_facility).where(req_approval: "request").find_by(user_id: id)] = item
      end
      @requests = hash.sort.reverse.to_h
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
      user = User.find(id)
      unless Relative.set_update_ids(update_ids) == user.resident_ids.sort
        user.update_attributes(update_ids)
        RequestResident.update_approval(current_facility, id)
      end
    end
    redirect_to facility_home_facility_url(current_facility), notice: "まとめて承認しました。"
  end

  # 個別に承認・否認
  def update
    @user = User.find(params[:user_id].to_i)
    if @user.update_with_context(update_params, context: :relative_update)
      request_resident = RequestResident.changer(current_facility, @user)
      request_resident.approval!
      flash[:notice] = "#{request_resident.user.name}の申請を承認しました。"
      request.referer.include?("edit") ? redirect_to(relatives_url) : redirect_to(facility_home_facility_url(current_facility))
    else
      request.referer.include?("edit") ? (render :edit) : (render :show)
    end
  end

  # 承認済み申請一覧
  def index
    @applied_ids = RequestResident.search(params[:search], current_facility)
  end

  def show; end

  def edit; end

  def destroy; end

  def denial
    @request = RequestResident.find(params[:id])
    @request.denial!
    RequestMailer.send_denial_to_user(current_facility, @request).deliver
    flash_message = "#{@request.user.name}の申請を否認しました。"

    respond_to do |format|
      format.html { flash[:notice] = flash_message
                    request.referer.include?("edit") ? redirect_to(relatives_url) : redirect_to(facility_home_facility_url(current_facility))
                  }
      format.js { flash.now[:notice] = flash_message }
    end
  end

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
end
