# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @omniauth = request.env['omniauth.auth']
    info = User.find_oauth(@omniauth)
    @user = info[:user]
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      # set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      @sns = info[:sns]
      render template: "devise/registrations/new"
    end
  end

  def failure
    redirect_to root_path and return
  end

  def line; basic_action end

  private

    def basic_action
      @omniauth = request.env['omniauth.auth']
      if @omniauth.present?
        @profile = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
        if @profile
          @profile.set_values(@omniauth)
          sign_in(:user, @profile)
        else
          @profile = User.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
          email = @omniauth['info']['email'] ? @omniauth['info']['email'] : "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
          @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email: email, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
          @profile.set_values(@omniauth)
          sign_in(:user, @profile)
          # redirect_to edit_user_path(@profile.user.id) and return
        end
          # Style/IdenticalConditionalBranches(rubocop) ⬇️⬇️これに書き換えても大丈夫なら変更
        # @profile = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
        # unless @profile
        #   @profile = User.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
        #   email = @omniauth['info']['email'] ? @omniauth['info']['email'] : "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
        #   @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email: email, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
        # end
        # @profile.set_values(@omniauth)
        # sign_in(:user, @profile)

      end
      redirect_to root_path, notice: "ログインしました"
    end

    def fake_email(uid, provider)
        return "#{auth.uid}-#{auth.provider}@example.com"
        # ↑"#{auth.uid}-#{auth.provider}@example.com"ここはreturnがなくて良さそう
    end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
