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
    title = params[:request_mail][:title]
    message = params[:request_mail][:message]
    RequestMailer.send_confirm_to_user(current_facility, request, title, message).deliver

    respond_to do |format|
      format.js { flash.now[:notice] = "#{request.user.name}様へ確認メールを送信しました。" }
    end
  end

  # private

  # def send_email_params
  #   params.require(:request_mail).permit(:title, :message)
  # end
end
