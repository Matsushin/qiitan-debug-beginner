class AccountActivationsController < ApplicationController
  skip_before_action :logged_in_user

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to root_path, notice: 'アカウントが有効になりました'
    else
      redirect_to login_path, alert: 'リンクが無効です'
    end
  end
end