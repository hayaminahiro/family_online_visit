class FacilityUsersController < ApplicationController
  before_action :facilities_users_correct_user, only: :facility_update

  def new
    @registered_facilities = current_user.facilities
    @facility_users = FacilityUser.search(params[:search], Facility.all, current_user).paginate(page: params[:page], per_page: 12)
  end

  def update
    params[:user][:facility_ids].delete("0") if params[:user].present?
    if params[:user].blank?
      flash[:alert] = "新しく施設を登録して下さい。"
    elsif params[:user][:facility_ids].map(&:to_i).sort == current_user.facilities.ids.sort
      flash[:alert] = "登録施設が更新されていません。登録チェック ✔️ を確認して更新して下さい。"
    elsif params[:user][:facility_ids].map(&:to_i).count > current_user.facilities.ids.count
      current_user.update_attributes(facilities_used_params)
      flash[:notice] = "新しく施設を登録しました。"
    elsif params[:user][:facility_ids].map(&:to_i).count < current_user.facilities.ids.count
      current_user.update_attributes(facilities_used_params)
      flash[:notice] = "登録施設を解除しました。"
    end
    redirect_to new_facility_user_url
  end

  def facility_update
    params[:user][:facility_ids].delete("0") if params[:user].present?
    if params[:user][:facility_ids].map(&:to_i).sort == current_user.facilities.ids.sort
      flash[:alert] = "解除する場合は 解除ボタンにチェック ✔️ を入れてください。"
    elsif params[:user][:facility_ids].map(&:to_i).count < current_user.facilities.ids.count
      current_user.update_attributes(facilities_used_params)
      flash[:notice] = "登録施設を解除しました。"
    end
    redirect_to edit_user_registration_url
  end

  def destroy
    @user = User.find(params[:id])
    @facility_user = FacilityUser.find_by(user_id: @user, facility_id: current_facility)
    @facility_user.destroy

    Relative.eager_load(:resident).where(user_id: @user).where(residents: { facility_id: current_facility }).destroy_all
    redirect_to users_url, alert: "#{@user.name}のデータを削除しました。"
  end

  private

    def facilities_used_params
      params[:user][:facility_ids].delete("0")
      params.require(:user).permit(facility_ids: [])
    end
end
