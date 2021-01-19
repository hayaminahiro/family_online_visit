class ResidentsController < ApplicationController
  before_action :set_resident, only: %i[edit update destroy]

  def index
    @residents = Resident.search(params[:search], current_facility).paginate(page: params[:page], per_page: 30)

    @image_columns = []
    @residents.each do |resident|
      resident.memories.where(created_at: Time.now.all_month).each do |m|
        @image_columns << m.image0 if m.image0?
        @image_columns << m.image1 if m.image1?
        @image_columns << m.image2 if m.image2?
        @image_columns << m.image3 if m.image3?
        @image_columns << m.image4 if m.image4?
        @image_columns << m.image5 if m.image5?
        @image_columns << m.image6 if m.image6?
        @image_columns << m.image7 if m.image7?
      end
    end
    @image_columns

  end

  def new
    @resident = Resident.new
  end

  def show
    @resident = Resident.find(params[:id])
    @resident.facility_id = current_facility.id
    @memories = @resident.memories
  end

  def create
    if params[:commit] == "登録する"
      @resident = Resident.new(resident_params)
      @resident.facility_id = current_facility.id
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
    @resident.facility_id = current_facility.id
    if @resident.update(resident_params)
      redirect_to residents_url, notice: "入居者情報を更新できました"
    else
      render :edit
    end
  end

  def destroy
    @resident.facility_id = current_facility.id
    @resident.destroy
    redirect_to residents_url, alert: "入居者情報を削除しました"
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
