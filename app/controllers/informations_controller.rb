class InformationsController < ApplicationController
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, only: [:top_notice, :show]
  before_action :authenticate_facility!, only: [:index, :create, :update, :destroy]
  before_action :set_information, only: [:show, :edit, :update, :destroy]

  def index
    @info_top = Information.find_by(status: "head")
    @informations = Information.where(facility_id: current_facility.id).where(status: "others").order(id: "DESC").paginate(page: params[:page], per_page: 9)
    if params[:search].present?
      @informations = @informations.where(facility_id: current_facility.id).where(status: "others").where('title LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 9).order(id: "DESC")
    end
    @information = Information.new
  end

  def show
  end

  def new
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    @information.facility_id = params[:facility_id].to_i
    if  @information.save
      flash[:notice] = "タイトル【#{@information.title}】/お知らせを新規作成できました。"
      redirect_to facility_informations_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    @information.facility_id = params[:facility_id].to_i
    if @information.update(information_params)
      flash[:notice] = "タイトル【#{@information.title}】/お知らせを更新できました。"
      if @information.status == "head"
        redirect_to facility_home_facility_url
      else
        redirect_to facility_informations_url
      end
    else
      render :edit
    end
  end

  def destroy
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

      def set_information
        @information = Information.find(params[:id])
      end

end
