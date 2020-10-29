class MemoriesController < ApplicationController

  def index
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories
  end

  def show
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories
  end

  def new
    @resident = current_facility.residents.find(params[:resident_id])
    @memory = @resident.memories.new
  end

  def create
    @resident = current_facility.residents.find(params[:resident_id])
    @memory = @resident.memories.new(memories_params)
    if @memory.save
      flash[:notice] = "#{@resident.name}さんの思い出アルバムを投稿しました。"
      # redirect_to facility_resident_path(id: @resident.id)
      redirect_to facility_resident_memories_path
    else
      render :new
    end
  end

  def destroy
    resident = current_facility.residents.find(params[:resident_id])
    memories = resident.memories
    @memory = memories.find(params[:id])
    @memory.delete
    @memory.remove_images!
    flash[:alert] = "思い出アルバムを削除しました"
    redirect_to facility_resident_memories_path
  end

    private

      def memories_params
        params.require(:memory).permit(:title, :message, {images: []}, {remove_images: []}, :images_cache)
      end

end
