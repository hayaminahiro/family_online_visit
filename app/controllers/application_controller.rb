class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configre_permitted_parameters, if: :devise_controller?

# deviseでユーザー新規作成の際に名前のカラムを保存するためのもの（標準装備はemail,passwordのみ）
  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :facility_name])
  end
end
