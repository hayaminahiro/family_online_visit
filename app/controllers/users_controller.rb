class UsersController < ApplicationController
  def index
    @users = User.where.not(admin: true)
  end

  def video_room
  end
end
