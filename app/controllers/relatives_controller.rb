class RelativesController < ApplicationController
  before_action :set_request, only: %i[show destroy]

  def new #家族から申請された内容を確認
    @requests = RequestResident.where(facility_id:current_facility).where(req_approval: "申請中")
    @residents = Relative.search(params[:search], current_facility)
  end

  def update #家族からの申請を承認・否認
    @user = User.find(params[:user_id].to_i)
    @request_resident = RequestResident.order(created_at: :desc).find_by(user_id: params[:user_id].to_i)
    if (params[:user][:resident_ids] == ["", ""]) == true
      flash[:alert] = "登録する入居者を選択してください。"
    else
      @user.update_attributes(residents_connection_params)
      flash[:notice] = "入居者登録しました。"
      @request_resident.承認済! #enumの値を「申請中→承認済」に更新
    end
    redirect_to facility_home_facility_url(current_facility)
  end

  def index #承認済み申請一覧
    @approvals = RequestResident.where(req_approval: "承認済").where(facility_id: current_facility)
  end

  def show
    @residents = Relative.search(params[:search], current_facility)
  end

  def destroy
    @request.否認済! #enumの値を「申請中→否認」に更新
    # @request.destroy
    redirect_to facility_home_facility_url(current_facility), notice: "[#{@request.req_name}][#{@request.req_phone}][#{@request.req_address}]の申請を否認しました。"
  end

    private

      def residents_connection_params
        params.require(:user).permit(resident_ids: [])
      end

      def set_request
        @request = RequestResident.find(params[:id])
      end
end
