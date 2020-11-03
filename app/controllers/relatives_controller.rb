class RelativesController < ApplicationController
  def new #家族から申請された内容を確認
    return @residents = current_facility.residents.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 9).order(:id) if params[:search].present?
    @residents = current_facility.residents.where('name LIKE ?', "")
  end

  def update #家族からの申請を承認・否認
    @user = User.find(params[:user_id].to_i)
    @request_resident = RequestResident.order(created_at: :desc).find_by(user_id: params[:user_id].to_i)
    if (params[:user][:resident_ids] == ["", ""]) == true
      @user.update_attributes(residents_connection_params)
      flash[:alert] = "登録する入居者を選択してください。"
      redirect_to facility_url(current_facility)
    else
      @user.update_attributes(residents_connection_params)
      flash[:notice] = "入居者登録しました。"
      redirect_to facility_url(current_facility)
      @request_resident.承認済! #enumの値を「申請中→承認済」に更新
    end
  end

  def index #承認済み申請一覧
    @approvals = RequestResident.where(req_approval: "承認済").where(facility_id: current_facility)
  end

    private

      def residents_connection_params
        params.require(:user).permit(resident_ids: [])
      end
end
