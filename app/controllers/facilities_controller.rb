class FacilitiesController < ApplicationController

  before_action :set_facility, only: [:edit, :update, :destroy, :correct_facility, :show]

  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!, except: :home
  before_action :authenticate_user!, only: :home

  def index
    @facilities = Facility.where.not(admin: true).paginate(page: params[:page], per_page: 30).order(:id)
    if params[:search].present?
      @facilities = Facility.where('facility_name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id)
    end
  end

  def edit
  end

  def update
    # passwordが空白でも編集できる
    if params[:facility][:password].blank? && params[:facility][:password_confirmation].blank?
      params[:facility].delete(:password)
      params[:facility].delete(:password_confirmation)
    end
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
