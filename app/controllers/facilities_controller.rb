class FacilitiesController < ApplicationController

  before_action :set_facility, only: [:edit, :update, :destroy, :correct_facility]

  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!

  def index
    @facilities = Facility.all
  end

  def show
  end

  def edit
  end

  def update
    if @facility.update_attributes(facility_params)
      flash[:notice] = "「#{@facility.facility_name}」の施設情報を更新できました。"
    else
      flash[:alert] = "更新できませんでした。入力内容をご確認ください。"
    end
    redirect_to facilities_url
  end

  def destroy
    @facility.destroy
    flash[:notice] = "「#{@facility.facility_name}」の施設情報を削除しました。"
    redirect_to facilities_url
  end

  def home #各施設のホーム画面
    @facility = Facility.find(params[:facility_id])
  end

    private

      def set_facility
        @facility = Facility.find(params[:id])
      end

      def facility_params
        params.require(:facility).permit(:facility_name, :email, :password,:password_confirmation)
      end

end
