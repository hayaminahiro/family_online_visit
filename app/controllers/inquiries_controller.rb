class InquiriesController < ApplicationController
  def inquiry
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to inquiry_inquiries_path, notice: "お問い合わせを完了しました。"
    else
      render "inquiry"
    end
  end

  def index
  end


  private
    def inquiry_params
      params.permit(:name, :email, :message)
    end
end
