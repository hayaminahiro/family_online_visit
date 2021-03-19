class AffiliationsController < ApplicationController
  before_action :set_user, only: %i[create destroy]

  def create
    @user.affiliations.create(facility_id: current_facility.id)
    redirect_to users_url, notice: "#{@user.name}さんを退所へ変更しました。"
  end

  def destroy
    Affiliation.find_by(facility_id: current_facility.id, user_id: @user).destroy
    redirect_to users_url, notice: "#{@user.name}さんを再入所しました。"
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
