class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or root_path
      else
        message = 'アカウントがアクティブになっていません。'
        message += '招待メールを確認してください'
        redirect_to login_path, alert: message
      end
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end