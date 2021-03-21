class StaticPagesController < ApplicationController
  def top
    @admin_informations = Information.where(status: "admin").order(id: "DESC").limit(15)
  end

  def error_top; end
end
