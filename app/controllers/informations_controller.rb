class InformationsController < ApplicationController
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, only: [:top_notice, :show]
  before_action :authenticate_facility!, only: [:index, :create, :update, :destroy]

  def index
    @info_top = Information.find_by(status: "head")
    @informations = Information.where(facility_id: current_facility.id).where(status: "others").order(id: "DESC").paginate(page: params[:page], per_page: 9)
    if params[:search].present?
      @informations = @informations.where(facility_id: current_facility.id).where(status: "others").where('title LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 9).order(id: "DESC")
    end
    @information = Information.new
  end

  def show
    @information = Information.find(params[:id])
  end

  def new
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    @information.facility_id = params[:facility_id].to_i
    if  @information.save
      flash[:notice] = "お知らせを新規作成できました"
    else
      flash[:alert] = "新規作成できませんでした。入力内容をご確認ください"
    end
    redirect_to facility_informations_url
  end

  def edit
    @information = Information.find(params[:id])
  end

  def update
    @information = Information.find(params[:id])
    @information.facility_id = params[:facility_id].to_i
    if @information.update(information_params)
      flash[:notice] = "更新できました"
    else
      flash[:alert] = "更新できませんでした。入力内容をご確認ください"
    end
    return redirect_to facility_home_facility_url if @information.status == "head"
    redirect_to facility_informations_url
  end

  def destroy
    @information = Information.find(params[:id])
    @information.destroy
    flash[:alert] = "お知らせを削除しました"
    redirect_to facility_informations_url
  end

  # 家族向けお知らせ表示ページ
  def top_notice
    @info_top = Information.find_by(status: "head")
    @informations = Information.where(facility_id: params[:facility_id].to_i).where(status: "others").order(id: "DESC")
  end

  private

  def information_params
    params.require(:information).permit(:news, :title, :image, :remove_image)
  end

end
