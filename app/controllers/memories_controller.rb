class MemoriesController < ApplicationController

  def index
    # raise
    @resident = current_facility.residents.find(params[:resident_id])
    # @resident.facility_id = current_facility.id
    @memories = @resident.memories
    # raise
  end

  def show
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories
  end

  def new
    @resident = current_facility.residents.find(params[:resident_id])
    @memory = @resident.memories.new
    # @resident.facility_id = current_facility.id
    # @resident = Resident.new
    # @images = @item.images.build
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
    # raise
    @resident = current_facility.residents.find(params[:resident_id])
    @memories = @resident.memories
    # raise
    @memories.each do |m|
      m.delete
    end


    # @memories.find(29).delete
    flash[:alert] = "思い出アルバムを削除しました"
    redirect_to facility_resident_memories_path
  end

  # def destroy
  #   @information.destroy
  #   flash[:alert] = "お知らせを削除しました"
  #   redirect_to facility_informations_url
  # end


    private

      def memories_params
        params.require(:memory).permit(:title, :message, {images: []})
      end

end
