class RequestMailsController < ApplicationController
  def preview_mail
    @request_mail = RequestMail.new
    request = RequestResident.find(params[:denial])
    @user = User.find(request.user_id)
    title = nil
    message = nil

    @message = RequestMailer.default_message(current_facility, request, title, message)
  end

  def send_mail
    request = RequestResident.find(params[:request_mail][:facility_id].to_i)
    user = User.find(params[:request_mail][:user_id].to_i)
    # フォームで入力された値の取得
    title = params[:request_mail][:title]
    message = params[:request_mail][:message]
    RequestMailer.send_confirm_to_user(current_facility, request, title, message).deliver

    redirect_to facility_home_facility_url(current_facility), notice: "#{user.name}様へ確認メールを送信しました。"
  end

  # private

  # def send_email_params
  #   params.require(:request_mail).permit(:title, :message)
  # end
end
