class MemoriesController < ApplicationController
  before_action :set_resident, only: %i[index new create]

  def index
    @memories = current_facility.residents.includes(:memories).where(id: params[:resident_id])
  end

  def show
    @memory = Memory.find(params[:id])
  end

  def new
    @memory = @resident.memories.new
    @memories = current_facility.residents.includes(:memories)
  end

  def create
    @memory = @resident.memories.new(memories_params)
    if @memory.save
      redirect_to memories_url(resident_id: @resident), notice: "#{@resident.name}さんの思い出アルバムを投稿しました。"
    else
      render :new
    end
  end

  def destroy
    @memory = Memory.find(params[:id])
    @memory.delete
    @memory.remove_r_images!
    redirect_to memories_url(resident_id: params[:resident_id]), alert: "思い出アルバムを削除しました"
  end

    private

      def memories_params
        params.require(:memory).permit(:title, :message, :event_date, {r_images: []}, {remove_images: []}, :images_cache)
      end

      def set_resident
        @resident = Resident.find(params[:resident_id])
      end
end
