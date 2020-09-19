class StaticPagesController < ApplicationController
  def top
    @info_top = Information.find_by(status: "head")
  end
end
