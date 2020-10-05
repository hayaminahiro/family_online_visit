class RequestResidentsController < ApplicationController
  def new #入居者登録申請画面
    @request = RequestResident.new
    @requests = RequestResident.order(created_at: :desc).find_by(user_id: current_user.id)
  end

  def create
    @request = RequestResident.new(request_params)
    @request.facility_id = params[:facility_id].to_i
    @request.user_id = current_user.id
    if @request.save(context: :create_request)
      flash[:notice] = "入居者申請できました"
      redirect_to user_facility_home_url
    else
      render 'new'
    end
  end

  def index #登録済み申請一覧
    @request_residents = RequestResident.where(req_approval: "登録済").where(facility_id: current_facility)
  end

    private

    def request_params
      params.require(:request_resident).permit(:req_name, :req_phone, :req_address, :req_approval)
    end
end
