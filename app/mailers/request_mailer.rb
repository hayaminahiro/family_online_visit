class RequestMailer < ApplicationMailer
  default from: "takahiro5393s@gmail.com"

  # デフォルトの文章を作成
  def default_message(facility, request, title, message)
    @facility = facility
    @request = request
    @title = title
    @message = message
    @user = User.find(request.user_id)

    mail(
      # 件名
      subject: "申請内容のご確認をお願い致します。",
      # 宛先
      # to: 'taka_5393@yahoo.co.jp'
      to: @user.email
    ) do |format|
      format.text
    end
  end

  def send_confirm_to_user(facility, request, title, message)
    @facility = facility
    @request = request
    @title = title
    @message = message
    @user = User.find(request.user_id)

    mail(
      subject: @title,
      # to: 'taka_5393@yahoo.co.jp'
      to: @user.email
    ) do |format|
      format.text
    end
  end

  # 変更がなかった場合に申請をキャンセルする文章を送信
  def send_denial_to_user(facility, request)
    @facility = facility
    @request = request
    @user = User.find(request.user_id)

    mail(
      subject: "申請内容がキャンセルされました。",
      to: 'taka_5393@yahoo.co.jp'
    ) do |format|
      format.text
    end
  end
end
