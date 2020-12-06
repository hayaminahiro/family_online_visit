class InquiriesController < ApplicationController
  before_action :authenticate_user!, only: %i[inquiry create]

  def inquiry
    @facility = Facility.find(params[:facility_id])
    if params[:name].present?
      @inquiry = Inquiry.new(inquiry_params)
    else
      @inquiry = Inquiry.new
    end
  end

  def inquiry_system
    if params[:name].present?
      @inquiry = Inquiry.new(inquiry_params)
    else
      @inquiry = Inquiry.new
    end
  end

  def create
    @facility = Facility.find(params[:facility_id])
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to inquiry_facility_inquiries_path(@facility), notice: "お問い合わせを完了しました。"
    else
      render "inquiry"
    end
  end

  def create_system
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to inquiry_system_inquiries_path, notice: "お問い合わせを完了しました。"
    else
      render "inquiry_system"
    end
  end

  def index
    @facility = Facility.find(params[:facility_id])
    @inquiry = Inquiry.where(facility_id: @facility.id)
  end

  private
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message, :facility_id)
    end
end
