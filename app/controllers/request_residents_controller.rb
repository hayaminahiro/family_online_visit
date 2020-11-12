class RequestResidentsController < ApplicationController
  def new #入居者登録申請
    @request = RequestResident.new
    @requests = current_user.request_residents.order(created_at: :desc).where(facility_id: params[:facility_id].to_i).first
  end

  def create
    @request = RequestResident.new(request_params)
    @request.facility_id, @request.user_id = params[:facility_id].to_i, current_user.id
    if @request.save(context: :create_request)
      redirect_to facility_home_url(@request.facility_id), notice: "入居者申請できました"
    else
      render 'new'
    end
  end

  # def show #自身の申請内容の確認
  # end

  # def index #自身の申請一覧
  # end

  # def destroy #申請取り消し
  # end

  private

    def request_params
      params.require(:request_resident).permit(:req_name, :req_phone, :req_address, :req_approval)
    end
end
