class InformationsController < ApplicationController
  def index
    @informations = Information.all
    @first_information = @informations.first
  end

  def new
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    if  @information.save
      flash[:success] = "お知らせを新規作成できました"
      redirect_to informations_path
    else
      render 'new'
    end
  end

  def edit
    @information = Information.find(params[:id])
  end

  def update
    @information = Information.find(params[:id])
    if @information.update(information_params)
      flash[:success] = "更新できました"
      redirect_to informations_path
    else
      render 'edit'
    end
  end

  def destroy
    @information = Information.find(params[:id])
    if @information.destroy
      flash[:danger] = "お知らせを削除しました"
      redirect_to informations_path
    end
  end

  private

  def information_params
    params.require(:information).permit(:news, :title)
  end
end
