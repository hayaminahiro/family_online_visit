class SignupController < ApplicationController
  before_action :validates_step1, only: :step2 # step1のバリデーション
  before_action :validates_step2, only: :step3 # step2のバリデーション

  # 各アクションごとに,新規インスタンスを作成します
  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    @user = User.new # 新規インスタンス作成
  end

  def step3
    @user = User.new # 新規インスタンス作成
  end

  # before_actionごとに、遷移元のページのデータをsessionに保管していきます
  # 仮でインスタンスを作成しバリデーションチェックを行います
  def validates_step1
    # step1で入力された値をsessionに保存
    session[:name] = user_params[:name]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      postal_code: "01010101", # 入力前の情報は、バリデーションに通る値を仮で入れる
      prefecture_name: "東京都",
      address_city: "お台場",
      address_street: "新宿",
      phone: "08022003300"
    )
    render 'step1' unless @user.valid?
  end

  def validates_step2
    # step2で入力された値をsessionに保存
    session[:postal_code] = user_params[:postal_code]
    session[:prefecture_name] = user_params[:prefecture_name]
    session[:address_city] = user_params[:address_city]
    session[:address_street] = user_params[:address_street]
    session[:phone] = user_params[:phone]
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      name: session[:name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      postal_code: session[:postal_code],
      prefecture_name: session[:prefecture_name],
      address_city: session[:address_city],
      address_street: session[:address_street],
      phone: session[:phone]
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render 'step2' unless @user.valid?
  end

  def create
    @user = User.new(
      name: session[:name],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      postal_code: session[:postal_code],
      prefecture_name: session[:prefecture_name],
      address_city: session[:address_city],
      address_street: session[:address_street],
      phone: session[:phone]
    )
    if @user.save
    # ログインするための情報を保管
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?
      redirect_to root_url, notice: "新規ユーザーを登録しました"
    else
      flash.now[:alert] = "登録できませんでした。"
      render 'step1'
    end
  end

  private
    # 許可するキーを設定します
    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :postal_code,
        :prefecture_name,
        :address_city,
        :address_street,
        :phone
      )
    end
end
