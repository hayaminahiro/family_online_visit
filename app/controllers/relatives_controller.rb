class RelativesController < ApplicationController
  before_action :set_request, only: %i[show update destroy]
  before_action :set_residents, only: %i[new show update update_relatives]

  def new #家族から申請された内容を確認
  end

  def update #家族からの申請を承認・否認
    @user = User.find(params[:user_id].to_i)
    @request_resident = RequestResident.order(created_at: :desc).find_by(user_id: params[:user_id].to_i)

    @user.attributes = connection_params
    if @user.save(context: :relative_update)
      @request_resident.承認済! #enumの値を「申請中→承認済」に更新
      redirect_to facility_home_facility_url(current_facility), notice: "入居者登録しました。"
    else
      render :show
    end
  end

  def update_relatives
    residents_connection_params.each do |id, item|
      @request_user = User.find(id)
      @request_user.attributes = item
      @request_resident = RequestResident.order(created_at: :desc).find_by(user_id: id)
    end

    if @request_user.save(context: :relative_update)
      @request_resident.承認済! #enumの値を「申請中→承認済」に更新
      redirect_to facility_home_facility_url(current_facility), notice: "入居者登録しました。"
    else
      render :new
    end
  end

  def index #承認済み申請一覧
    @approvals = RequestResident.where(req_approval: "承認済").where(facility_id: current_facility)
  end

  def show
    @user = User.find(@request.user_id)
  end

  def destroy
    @request.否認済! #enumの値を「申請中→否認」に更新
    redirect_to facility_home_facility_url(current_facility), notice: "[#{@request.req_name}][#{@request.req_phone}][#{@request.req_address}]の申請を否認しました。"
  end

    private

      def connection_params
        params.require(:user).permit(resident_ids: [])
      end

      def residents_connection_params
        params.require(:facility).permit(request_residents:[resident_ids:[]])[:request_residents]
      end

      def set_request
        @request = RequestResident.find(params[:id])
      end

      def set_residents
        @requests = RequestResident.where(facility_id:current_facility).where(req_approval: "申請中")
        @residents = Relative.search(params[:search], current_facility)
      end
end
