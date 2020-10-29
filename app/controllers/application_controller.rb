class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configre_permitted_parameters, if: :devise_controller?

# deviseでユーザー新規作成の際に名前のカラムを保存するためのもの（標準装備はemail,passwordのみ）
  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :facility_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:floor_authority])
  end

  private

    # ユーザーまたは施設のログイン後リダイレクト先
    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(Facility)
        facility_home_facility_path(id: current_facility)
      else
        root_path
      end
    end
end
