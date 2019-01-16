class PasswordResetsController < ApplicationController
  skip_before_action :logged_in_user
  before_action :set_user,   only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to new_password_reset_path, notice: '入力したメールアドレスにパスワード再設定メールを送りました'
    else
      flash.now[:alert] = 'メールアドレスが見つかりません'
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      redirect_to root_path, notice: 'パスワードが再設定されました'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(email: params[:email] || params.dig(:user, :email))
  end

  def valid_user
    if not (@user && @user.activated? &&
        @user.authenticated?(:reset, params[:id]))
      redirect_to login_path, alert: 'ユーザが見つかりません'
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      redirect_to new_password_reset_url, alert: 'パスワード再設定の有効期限がきれています'
    end
  end
end