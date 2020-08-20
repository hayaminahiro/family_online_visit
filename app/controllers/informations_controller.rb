class InformationsController < ApplicationController
  def index
    @info_top = Information.find_by(status: "head")
    @informations = Information.where(status: "others")
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    if  @information.save
      flash[:success] = "お知らせを新規作成できました"
    else
      flash[:danger] = "新規作成できませんでした。入力内容をご確認ください"
    end
    redirect_to informations_path
  end

  def update
    @information = Information.find(params[:id])
    if @information.update(information_params)
      flash[:success] = "更新できました"
    else
      flash[:danger] = "更新できませんでした。入力内容をご確認ください"
    end
    redirect_to informations_path
  end

  def destroy
    @information = Information.find(params[:id])
    @information.destroy
    flash[:danger] = "お知らせを削除しました"
    redirect_to informations_path
  end
  # 家族向けお知らせ表示ページ
  def show_notice
    @info_top = Information.find_by(status: "head")
    @informations = Information.where(status: "others")
  end

  private

  def information_params
    params.require(:information).permit(:news, :title)
  end

end
