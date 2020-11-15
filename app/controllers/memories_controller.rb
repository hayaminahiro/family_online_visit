class MemoriesController < ApplicationController
  before_action :set_resident, only: %i[index show new create edit update destroy]
  before_action :set_memories, only: %i[index show edit update]
  before_action :set_memory, only: %i[show edit update]

  def index
    # raise
    #
    # @memories.find(8).remove_image0!
    # @memories.find(8).save!
  end

  def show
  end

  def new
    @memory = @resident.memories.new
  end

  def create
    @memory = @resident.memories.new(memories_params)
    if @memory.save
      redirect_to resident_memories_url, notice: "#{@resident.name}さんの思い出アルバムを投稿しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
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
    redirect_to resident_memories_url, alert: "#{resident.name}さんの思い出アルバムを削除しました"
  end

  def solo_image
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories.order(updated_at: "DESC")
    @memory_id = params[:memory_id]
    @column = params[:column]
  end

    private

      def set_resident
        @resident = current_facility.residents.find(params[:resident_id])
      end

      def set_memories
        @memories = @resident.memories.order(updated_at: "DESC")
      end

      def set_memory
        @memory = @memories.find(params[:id])
      end

      def memories_params
        params.require(:memory).permit(:title, :message, :event_date,
                                       :image0, :image1, :image2, :image3, :image4, :image5, :image6, :image7,
                                       :remove_image0, :remove_image1, :remove_image2, :remove_image3, :remove_image4, :remove_image5, :remove_image6, :remove_image7,
                                       :image0_cache, :image1_cache, :image2_cache, :image3_cache, :image4_cache, :image5_cache, :image6_cache, :image7_cache)
      end

end
