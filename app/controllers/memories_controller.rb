class MemoriesController < ApplicationController

  def index
    @resident = Resident.find(params[:resident_id])
    @resident.facility_id = current_facility.id
    @memories = @resident.memories
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
      flash[:notice] = "成功"
      # redirect_to facility_resident_path(id: @resident.id)
      redirect_to facility_resident_memories_path
    else
      render :new
    end

  end

    private

      def memories_params
        params.require(:memory).permit(:title, :message, {images: []})
      end

end
