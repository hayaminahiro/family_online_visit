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
    if params[:commit] == "登録する"
      @resident = Resident.new(resident_params)
      @resident.facility_id = current_facility.id
      if @resident.save
        flash[:notice] = "入居者を新規登録できました"
        redirect_to facility_residents_url
      else
        render :new
      end
    else
      # 入居者一覧からのCSVインポート
      if params[:file].content_type == "text/csv"
        registered_count = import_residents
        unless @errors.count == 0
          flash[:alert] = "#{@errors.count}件登録に失敗しました"
        end
        unless registered_count == 0
          flash[:notice] = "#{registered_count}件登録しました"
        end
        redirect_to facility_residents_url(error_residents: @errors)
      else
        flash[:alert] = "CSVファイルのみ有効です"
        redirect_to facility_residents_url
      end
    end
  end

  def edit
  end

  def update
    @resident.facility_id = current_facility.id
    if @resident.update(resident_params)
      flash[:notice] = "入居者情報を更新できました"
      redirect_to facility_residents_url
    else
      render :edit
    end
  end

  def destroy
    @resident.facility_id = current_facility.id
    @resident.destroy
    flash[:alert] = "入居者情報を削除しました"
    redirect_to facility_residents_url
  end

    private

      def resident_params
        params.require(:resident).permit(:name, :charge_worker)
      end

      def set_resident
        @resident = Resident.find(params[:id])
      end

      # CSVインポート
      def import_residents
        # 登録処理前のレコード数
        current_user_count = ::Resident.count
        residents = []
        @errors = []
        CSV.foreach(params[:file].path, headers: true) do |row|
          resident = Resident.new({ id: row["id"], name: row["name"], charge_worker: row["charge_worker"], facility_id: current_facility.id})
          if resident.valid?
              residents << ::Resident.new({id: row["id"], name: row["name"], charge_worker: row["charge_worker"], facility_id: current_facility.id})
          else
            @errors << resident.errors.full_messages.join(',')
            Rails.logger.warn(resident.errors.inspect)
          end
        end
        # importメソッドでバルクインサートできる
        ::Resident.import(residents)
        # 何レコード登録できたかを返す
        ::Resident.count - current_user_count
      end
end
