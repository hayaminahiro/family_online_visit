class StaticPagesController < ApplicationController
  def top
    @informations = Information.where(status: "head").order(id: "DESC")
  end
end
