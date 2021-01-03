class TagImagesController < ApplicationController
  def new
    @tag_image = TagImage.new
  end

  def create
    @tag_image = current_user.tag_images.build(tag_image_params)

    respond_to do |format|
      if !@tag_image.tag.tag_images.map(&:image).include?(@tag_image.image)
        @tag_image.save
        format.html
        format.js { flash.now[:notice] = "#{Tag.find(@tag_image.tag_id).title}フォルダに画像を追加しました" }
      else
        format.js { flash.now[:alert] = "#{Tag.find(@tag_image.tag_id).title}フォルダにはすでに同じ画像が登録されています" }
      end
    end
  end

  def destroy
    @tag_image = TagImage.find(params[:id])

    respond_to do |format|
      if @tag_image.destroy
        format.html
        format.js { flash.now[:alert] = "#{Tag.find(@tag_image.tag_id).title}フォルダから画像を削除しました" }
        # else
        # format.js { render :new }
      end
    end
  end

  private

    def tag_image_params
      params.require(:user).permit(:image, :tag_id)
    end
end
