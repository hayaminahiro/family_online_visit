class UsersController < ApplicationController
  def index
  end

  def video_room
  end

  def change_admin
    @user = User.find(params[:id])
    if @user.update_attributes(admin_params)
      flash[:notice] = "権限を変更します"
      redirect_to root_path
    else
      flash[:alert] = "権限を変更できませんでした"
    end
    render :root
  end

  def new_admin
    @user = User.new
  end

  private

  def admin_params
    params.permit(:floor_authority)
  end
end
