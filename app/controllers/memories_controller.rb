class MemoriesController < ApplicationController

  def index
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories.order(updated_at: "DESC")
  end

  def show
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories
    @memory = @memories.find(params[:id])
  end

  def new
    @resident = current_facility.residents.find(params[:resident_id])
    @memory = @resident.memories.new

  end

  def create
    @resident = current_facility.residents.find(params[:resident_id])
    @memory = @resident.memories.new(memories_params)
    if @memory.save
      redirect_to resident_memories_url, notice: "#{@resident.name}さんの思い出アルバムを投稿しました。"
    else
      render :new
    end
  end

  def edit
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories
    @memory = @memories.find(params[:id])
  end

  def update
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories
    @memory = @memories.find(params[:id])
    if @memory.update(memories_params)
      redirect_to resident_memory_url, notice: "#{@resident.name}さんの思い出アルバムを編集しました。"
    else
      render :edit
    end
  end

  def destroy
    resident = current_facility.residents.find(params[:resident_id])
    memories = resident.memories
    @memory = memories.find(params[:id])
    @memory.delete
    # @memory.remove_images!
    redirect_to resident_memories_url, alert: "思い出アルバムを削除しました"
  end

    private

      def memories_params
        params.require(:memory).permit(:title, :message, :event_date,
                                       :image0, :image1, :image2, :image3, :image4, :image5, :image6, :image7,
                                       :remove_image0, :remove_image1, :remove_image2, :remove_image3, :remove_image4, :remove_image5, :remove_image6, :remove_image7,
                                       :image0_cache, :image1_cache, :image2_cache, :image3_cache, :image4_cache, :image5_cache, :image6_cache, :image7_cache)
      end

end
