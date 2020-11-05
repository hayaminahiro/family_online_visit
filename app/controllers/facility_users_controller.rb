class FacilityUsersController < ApplicationController
  def new
    @facility_users = Facility.all.where.not(admin: true)

    return @facility_users = @facility_users.where('facility_name LIKE ?', "%#{params[:search]}%").where.not(id: current_user.facilities).paginate(page: params[:page], per_page: 12).order(:id) if params[:search].present?
    @facility_users = @facility_users.where('facility_name LIKE ?', "")
  end

  def update
    if params[:user].present?
      params[:user][:facility_ids].delete("0")
    end
    if params[:user].blank?
      flash[:alert] = "新しく施設を登録して下さい。"
    elsif params[:user][:facility_ids].map{|n| n.to_i}.sort == current_user.facilities.ids.sort
      flash[:alert] = "登録施設が更新されていません。登録チェック ✔️ を確認して更新して下さい。"
    elsif params[:user][:facility_ids].map{|n| n.to_i}.count > current_user.facilities.ids.count
      current_user.update_attributes(facilities_used_params)
      flash[:notice] = "新しく施設を登録しました。"
    elsif params[:user][:facility_ids].map{|n| n.to_i}.count < current_user.facilities.ids.count
      current_user.update_attributes(facilities_used_params)
      flash[:notice] = "登録施設を解除しました。"
    end
    redirect_to new_facility_user_url
  end

    private

      def facilities_used_params
        params[:user][:facility_ids].delete("0")
        params.require(:user).permit(facility_ids: [])
      end
end
