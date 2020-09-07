class FacilitiesController < ApplicationController

  before_action :set_facility, only: [:update]

  # ログインしてなければ閲覧不可
  # before_action :authenticate_facility!

  def index
    @facilities = Facility.all
    # raise
    # @facility = current
    # @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if  @facility.save
      flash[:success] = "施設を新規登録できました"
    else
      flash[:danger] = "施設登録できませんでした。入力内容をご確認ください"
    end
    redirect_to facilities_path(facility_id: params[:facility_id])
  end

  def update
    @facility = Facility.find(params[:id])
    if @facility.update(facility_params)
      flash[:success] = "施設情報を更新できました"
    else
      flash[:danger] = "更新できませんでした。入力内容をご確認ください"
    end
    redirect_to facilities_path(facility_id: params[:facility_id])
  end

  def destroy
    @facility = Facility.find(params[:id])
    @facility.destroy
    flash[:danger] = "施設情報を削除しました"
    redirect_to facilities_path(facility_id: params[:facility_id])
  end

  def home #各施設のホーム画面
    @facility = Facility.find(params[:facility_id])
  end

  private

  def set_facility
    @facility = Facility.find(params[:id])
  end

  def facility_params
    params.require(:facility).permit(:facility_name)
  end

end
