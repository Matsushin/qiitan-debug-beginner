class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :authorize_basic
  before_action :logged_in_user

  protected

  private

  def authorize_basic
    return unless Rails.env.production?
    authenticate_or_request_with_http_basic('BA') do |name, password|
      name == ENV['BASIC_NAME'] && password == ENV['BASIC_PASSWORD']
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_path, alert: 'ログインしてください'
    end
  end
end
