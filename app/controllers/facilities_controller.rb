class FacilitiesController < ApplicationController

  before_action :authenticate_user! # ログインしてなければ閲覧不可

  def index
  end
end
