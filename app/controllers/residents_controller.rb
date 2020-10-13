class ResidentsController < ApplicationController
  before_action :set_resident, only: [:edit, :update, :destroy]

  def index
      @residents = Resident.all.where(facility_id: current_facility.id).paginate(page: params[:page], per_page: 30)
    if params[:search].present?
      @residents = @residents.where(facility_id: current_facility.id).where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page], per_page: 30).order(:id)
    end
  end

  def new
    @resident = Resident.new
  end

  def create
    @resident = Resident.new(resident_params)
    @resident.facility_id = current_facility.id
    if @resident.save
      flash[:notice] = "入居者を新規登録できました"
      redirect_to facility_residents_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @resident.facility_id = current_facility.id
    if @resident.update(resident_params)
      flash[:notice] = "入居者情報を更新できました"
      redirect_to facility_residents_path
    else
      render :edit
    end
  end

  def destroy
    @resident.facility_id = current_facility.id
    @resident.destroy
    flash[:alert] = "入居者情報を削除しました"
    redirect_to facility_residents_path
  end

  def import
    Resident.current_facility = current_facility
    if params[:file].blank?
      flash[:alert] = "ファイルが選択されていません"
    elsif File.extname(params[:file].original_filename) != ".csv"
      flash[:alert] = "インポート可能なファイルではありません"
    else
      Resident.import(params[:file])
      flash[:notice] = "CSVファイルをインポートしました"
    end
      redirect_to facility_residents_path
  end

  private

    def resident_params
      params.require(:resident).permit(:name, :charge_worker)
    end

    def set_resident
      @resident = Resident.find(params[:id])
    end
end
