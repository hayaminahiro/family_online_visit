class InformationsController < ApplicationController
  # ログインしてなければ閲覧不可
  before_action :authenticate_user!, only: :show
  before_action :authenticate_facility!, only: %i[index create new update destroy]
  before_action :set_information, only: %i[show edit update destroy]

  def index
    @admin_informations = Information.where(status: "admin").order(id: "DESC")
    @informations = Information.search(params[:search], current_facility).paginate(page: params[:page], per_page: 9)
  end

  def show; end

  def new
    @information = if params[:image_cache].present?
                     Information.new(information_params)
                   else
                     Information.new
                   end
  end

  def create
    @information = current_facility.build_with_url(information_params)
    @information.admin! if current_facility.admin?
    if @information.save
      redirect_to informations_url, notice: "タイトル【#{@information.title}】/お知らせを新規作成できました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    @information.admin! if current_facility.admin?
    if @information.update_with_url(information_params)
      flash[:notice] = "タイトル【#{@information.title}】/お知らせを更新できました。"
      @information.status == "admin" ? redirect_to(facility_home_facility_url) : redirect_to(informations_url)
    else
      render :edit
    end
  end

  def destroy
    @information.destroy
    redirect_to informations_url, alert: "お知らせを削除しました"
  end

  private

    def information_params
      params.require(:information).permit(:news, :title, :image, :remove_image, :image_cache, :url)
    end

    def set_information
      @information = Information.find(params[:id])
    end
end
