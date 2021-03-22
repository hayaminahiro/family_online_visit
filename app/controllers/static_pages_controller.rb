class StaticPagesController < ApplicationController
  def top
    @admin_informations = Information.admin_list
  end

  def error_top; end
end
