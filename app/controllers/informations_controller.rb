class InformationsController < ApplicationController
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, only: %i[top_notice show]
  before_action :authenticate_facility!, only: %i[index create new update destroy]
  before_action :set_information, only: %i[show edit update destroy]

  def index
    @info_top = Information.find_by(status: "head")
    @information = Information.new
    return @informations = current_facility.informations.where(status: "others").where('title LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 9).order(id: "DESC") if params[:search].present?

    @informations = current_facility.informations.where(status: "others").order(id: "DESC").paginate(page: params[:page], per_page: 9)
  end

  def show; end

  def new
    if params[:image_cache].present?
      @information = Information.new(information_params)
    else
      @information = Information.new
    end
  end

  def create
    @information = Information.new(information_params)
    @information.facility_id = current_facility.id
    if @information.save
      redirect_to informations_url, notice: "タイトル【#{@information.title}】/お知らせを新規作成できました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    @information.facility_id = current_facility.id
    if @information.update(information_params)
      flash[:notice] = "タイトル【#{@information.title}】/お知らせを更新できました。"
      @information.status == "head" ? redirect_to(facility_home_facility_url) : redirect_to(informations_url)
    else
      render :edit
    end
  end

  def destroy
    @information.destroy
    redirect_to informations_url, alert: "お知らせを削除しました"
  end

  # 家族向けお知らせ表示ページ
  def top_notice
    @info_top = Information.find_by(status: "head")
    @informations = Information.where(facility_id: params[:facility_id].to_i).where(status: "others").order(id: "DESC")
  end

  private

    def information_params
      params.require(:information).permit(:news, :title, :image, :remove_image, :image_cache)
    end

    def set_information
      @information = Information.find(params[:id])
    end

end
