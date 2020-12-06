class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    if @inquiry.facility_id.present?
      # 施設へのお問い合わせ
      facility = Facility.find_by(id: @inquiry.facility_id)
      mail(
        from: @inquiry.email,
        to:   facility.email,
        subject: '[family-online-visitお問い合わせ窓口]　' + facility.facility_name + '様へお問い合わせ通知'
      )
    else
      # システムのお問い合わせ
      mail(
        from: "toyo.yuya0311@gmail.com",
        to:   @inquiry.email,
        subject: 'family-online-visitお問い合わせ通知'
      )
    end
  end
end
