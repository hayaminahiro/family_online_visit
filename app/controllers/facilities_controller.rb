class FacilitiesController < ApplicationController

  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!

  def index
  end

  def show
  end

end
