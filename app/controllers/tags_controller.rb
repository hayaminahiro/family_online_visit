class TagsController < ApplicationController
  # ログインしてなければ閲覧不可
  # before_action :authenticate_user!, only: %i[]
  # before_action :authenticate_facility!, only: %i[]
  # before_action :set_tag, only: %i[]

  # def index; end

  def show
    params[:tag].present? ? @all_image = params[:tag] : @tag = Tag.find(params[:id])
    @residents = current_user.residents.includes(:memories)
  end

  def new
    @tag = Tag.new
  end

  def create
    @informations = Information.where(facility_id: current_user.facilities).where(status: "others")
    @residents = current_user.residents.includes(:memories)
    @tag = current_user.tags.build(tag_params)

    respond_to do |format|
      if @tag.save
        format.html
        format.js { flash.now[:notice] = "#{@tag.title}フォルダを追加しました" }
      else
        format.js { render :new }
      end
    end
  end

  # def edit; end

  # def update; end

  def destroy
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.destroy
        format.html
        format.js { flash.now[:alert] = "#{@tag.title}フォルダを削除しました" }
        # else
        # format.js { render :new }
      end
    end
  end

  private

    def tag_params
      params.require(:tag).permit(:title)
    end

  #   def set_tag
  #     @tag = Tag.find(params[:id])
  #   end
end
