class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configre_permitted_parameters, if: :devise_controller?

  ACCESS_ERROR_MSG = "お探しのページが見つからなかったため遷移できませんでした。もう一度ご確認してください。"

  # 例外処理
  # rescue_from Exception, with: :render_500
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404

  # def render_500(exception = nil)
  #   logger.info "Rendering 500 with exception: #{exception.message}" if exception

  #   if request.xhr?
  #     render json: { error: '500 error' }, status: 500
  #   else
  #     render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  #   end
  # end

  # def render_404(exception = nil)
  #   logger.info "Rendering 404 with exception: #{exception.message}" if exception

  #   if request.xhr?
  #     render json: { error: '404 error' }, status: 404
  #   else
  #     render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  #   end
  # end

  # deviseでユーザー新規作成の際に名前のカラムを保存するためのもの（標準装備はemail,passwordのみ）
  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name facility_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[image])
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

    # アクセスしたユーザーが現在ログインしているユーザーかの確認
    def correct_user
      return true if @user == current_user

      redirect_to user_path(current_user), alert: ACCESS_ERROR_MSG
    end

    # ご家族ユーザーは登録施設のみアクセスができることの確認
    def user_registered_facility
      return true if current_user.facilities.find_by(id: @facility.id).present?

      redirect_to user_path(current_user), alert: ACCESS_ERROR_MSG
    end

    # アクセスしたユーザーがご家族本人か登録施設かの確認
    def correct_user_or_facility
      @correct_facility = @user.facilities.find_by(id: @facility.id)
      return true if @user == current_user || @correct_facility == current_facility

      if current_user
        redirect_to user_path(current_user), alert: ACCESS_ERROR_MSG
      elsif current_facility
        redirect_to facility_home_facility_path(current_facility), alert: ACCESS_ERROR_MSG
      end
    end

    # アクセスしたユーザーが登録申請を完了または登録申請された施設かの確認
    def request_done_user
      @correct_user = current_user.request_residents.find_by(facility_id: @facility.id, req_approval: "approval")
      return true if @correct_user || @facility == current_facility

      if current_user
        redirect_to user_path(current_user), alert: ACCESS_ERROR_MSG
      elsif current_facility
        redirect_to facility_home_facility_path(current_facility), alert: ACCESS_ERROR_MSG
      end
    end

    # 予約関連ページにアクセスしたご家族ユーザーがログインユーザーまたは登録施設がログインユーザーであるかの確認
    def correct_user_reservation
      @user = User.find(@reservation.user_id)
      return true if @user == current_user || @facility == current_facility

      if current_user
        redirect_to user_path(current_user), alert: ACCESS_ERROR_MSG
      elsif current_facility
        redirect_to facility_home_facility_path(current_facility), alert: ACCESS_ERROR_MSG
      end
    end
end
