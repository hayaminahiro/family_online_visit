class ResidentsController < ApplicationController
  def index
    @residents = Resident.all.paginate(page: params[:page], per_page: 30)
    @resident = Resident.new
  end

  def create
    @resident = Resident.new(resident_params)
    if  @resident.save
      flash[:notice] = "入居者を新規登録できました"
    else
      flash[:alert] = "入居者登録できませんでした。入力内容をご確認ください"
    end
    redirect_to residents_path
  end

  def update
    @resident = Resident.find(params[:id])
    if @resident.update(resident_params)
      flash[:notice] = "入居者情報を更新できました"
    else
      flash[:alert] = "更新できませんでした。入力内容をご確認ください"
    end
    redirect_to residents_path
  end

  def destroy
    @resident = Resident.find(params[:id])
    @resident.destroy
    flash[:alert] = "入居者情報を削除しました"
    redirect_to residents_path
  end

  private

  def resident_params
    params.require(:resident).permit(:name, :charge_worker)
  end
end
