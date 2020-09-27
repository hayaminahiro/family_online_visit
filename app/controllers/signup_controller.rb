class SignupController < ApplicationController
  
  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    @user = User.new # 新規インスタンス作成
  end

  def step3
    # step2で入力された値をsessionに保存
    session[:address] = user_params[:address]
    session[:phone] = user_params[:phone]
    @user = User.new # 新規インスタンス作成
  end

  def create
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      address: session[:address],
      phone: session[:phone]
    )
    if @user.save
   # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to done_signup_index_path
    else
      render '/signup/registration'
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private
   # 許可するキーを設定します
      def user_params
      params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation,
          :address,
          :phone
      )
      end
end
