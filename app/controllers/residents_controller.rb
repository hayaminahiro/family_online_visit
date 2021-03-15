class ResidentsController < ApplicationController
  before_action :set_resident, only: %i[show edit update destroy leave_update]

  def index
    @residents = Resident.where(enrolled: true).search(params[:search], current_facility).paginate(page: params[:page], per_page: 30)
    @leave_residents = Resident.where(enrolled: false).search(params[:search], current_facility).paginate(page: params[:page], per_page: 30)

    @select_month = params[:date].nil? ? Time.current : params[:date].to_date
    @total_image_count = Memory.total_image_count(current_facility.residents, @select_month)
  end

  def new
    @resident = Resident.new
  end

  def show
    @memories = @resident.memories
  end

  def create
    if params[:commit] == "登録する"
      @resident = Resident.new(resident_params)
      if @resident.save
        redirect_to residents_url, notice: "入居者を新規登録できました"
      else
        render :new
      end
    elsif params[:file].content_type == "text/csv"
      # 入居者一覧からのCSVインポート
      registered_count = import_residents
      flash[:alert] = "#{@errors.count}件登録に失敗しました" unless @errors.count.zero?
      flash[:notice] = "#{registered_count}件登録しました" unless registered_count.zero?
      redirect_to residents_url(error_residents: @errors)
    else
      redirect_to residents_url, alert: "CSVファイルのみ有効です"
    end
  end

  def edit; end

  def update
    if @resident.update(resident_params)
      redirect_to residents_url, notice: "入居者情報を更新できました"
    else
      render :edit
    end
  end

  def destroy
    @resident.destroy
    Relative.eager_load(:resident).where(resident_id: params[:id]).where(residents: { facility_id: current_facility }).destroy_all
    redirect_to residents_url, alert: "入居者情報を削除しました"
  end

  def leave_update
    if @resident.enrolled?
      @resident.update(enrolled: false)
      redirect_to residents_url, alert: "#{@resident.name}さんを退所登録しました。"
    else
      @resident.update(enrolled: true)
      redirect_to residents_url, notice: "#{@resident.name}さんを再入所登録しました。"
    end
  end

  private

    def resident_params
      params.require(:resident).permit(:name, :charge_worker)
    end

    def set_resident
      @resident = Resident.find(params[:id])
      @resident.facility_id = current_facility.id
    end

    # CSVインポート
    def import_residents
      # 登録処理前のレコード数
      current_user_count = ::Resident.count
      residents = []
      @errors = []
      CSV.foreach(params[:file].path, headers: true) do |row|
        resident = Resident.new({ id: row["id"], name: row["name"], charge_worker: row["charge_worker"], facility_id: current_facility.id })
        if resident.valid?
            residents << ::Resident.new({ id: row["id"], name: row["name"], charge_worker: row["charge_worker"], facility_id: current_facility.id })
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
