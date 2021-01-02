class InquiriesController < ApplicationController
  before_action :set_facility_id, only: %i[inquiry create index]
  before_action :set_inquiry, only: %i[inquiry inquiry_system]
  before_action :authenticate_user!, only: %i[inquiry create]
  before_action :authenticate_facility!, only: %i[index destroy]

  def inquiry; end

  def inquiry_system; end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to facility_home_url(@facility), notice: "お問い合わせを完了しました。"
    else
      render :inquiry
    end
  end

  def create_system
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to root_url, notice: "お問い合わせを完了しました。"
    else
      render :inquiry_system
    end
  end

  def index
    @inquiries = Inquiry.search(params[:search], current_facility).paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    redirect_to facility_inquiries_url(current_facility), alert: "#{@inquiry.name}のデータを削除しました。"
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  private

    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message, :facility_id)
    end

    def set_facility_id
      @facility = Facility.find(params[:facility_id])
    end

    def set_inquiry
      @inquiry = if params[:name].present?
                  Inquiry.new(inquiry_params)
                 else
                  Inquiry.new
                 end
    end
end
