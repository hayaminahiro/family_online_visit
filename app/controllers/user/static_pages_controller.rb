class User::StaticPagesController < User::Base
  def top
    @informations = Information.where(status: "head").order(id: "DESC")
    @info_top = Information.find_by(status: "head")
  end
end