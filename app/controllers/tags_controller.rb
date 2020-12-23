class TagsController < ApplicationController
  # ログインしてなければ閲覧不可
  # before_action :authenticate_user!, only: %i[top_notice show]
  # before_action :authenticate_facility!, only: %i[index create new update destroy]
  # before_action :set_tag, only: %i[show edit update destroy]

  # def index
  #   @info_top = Tag.find_by(status: "head")
  #   @tags = Tag.search(params[:search], current_facility).paginate(page: params[:page], per_page: 9)
  # end

  def show
    params[:tag].present? ? @all_image = params[:tag] : @tag = Tag.find(params[:id])
    @residents = current_user.residents.includes(:memories)
    @select_tags = Tag.where(user_id: current_user.id)
  end

  def new
    @tag = Tag.new
  end

  def create

    @informations = Information.where(facility_id: current_user.facilities).where(status: "others")
    @residents = current_user.residents.includes(:memories)
    @tags = Tag.where(user_id: current_user.id)

    @tag = current_user.tags.build(tag_params)
    # if @tag.save
    #   redirect_to user_path(current_user), notice: "新規作成できました。"
    # else
    #   render :new
    # end

    respond_to do |format|
      if @tag.save
        @select_tags = Tag.where(user_id: current_user.id)
        format.html
        format.js
      else
        format.js {render :new}
      end
    end


  end

  # def edit; end

  # def update
  #   @tag.facility_id = current_facility.id
  #   if @tag.update(tag_params)
  #     flash[:notice] = "タイトル【#{@tag.title}】/お知らせを更新できました。"
  #     @tag.status == "head" ? redirect_to(facility_home_facility_url) : redirect_to(tags_url)
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.destroy
        @select_tags = Tag.where(user_id: current_user.id)
        format.html
        format.js
      else
        format.js {render :new}
      end
    end
    # redirect_to user_url(current_user), alert: "お知らせを削除しました"
  end

  private

    def tag_params
      params.require(:tag).permit(:title)
    end

  #   def set_tag
  #     @tag = Tag.find(params[:id])
  #   end

end
