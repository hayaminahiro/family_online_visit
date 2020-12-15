class RequestResidentsController < ApplicationController
  before_action :set_request, only: %i[edit update destroy]

  # 入居者登録申請
  def new
    @request = RequestResident.new
    @request_resident = current_user.request_residents.order(created_at: :desc).where(facility_id: params[:facility_id].to_i).first
  end

  def create
    @request = current_user.request_residents.build(request_params)
    if @request.save(context: :create_request)
      redirect_to facility_home_url(@request.facility_id), notice: "入居者申請できました"
    else
      render 'new'
    end
  end

  # 自身の申請内容の変更
  def edit; end

  def update
    @request.attributes = request_params
    if @request.save(context: :create_request)
      redirect_to facility_home_url(@request.facility_id), notice: "申請内容を変更しました"
    else
      render 'edit'
    end
  end

  # 自身の申請内容の確認
  # def show
  # end

  # 自身の申請一覧
  # def index
  # end

  # 申請取り消し
  def destroy
    @request.destroy
    redirect_to facility_home_url(@request.facility_id), notice: "申請をキャンセルしました"
  end

  private

    def set_request
      @request = RequestResident.find(params[:id])
    end

    def request_params
      params.require(:request_resident).permit(:req_name, :req_phone, :req_address, :req_approval, :facility_id)
    end
end
