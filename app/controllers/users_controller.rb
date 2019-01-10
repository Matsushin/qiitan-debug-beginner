class UsersController < ApplicationController
  LIKED_REQUEST = 'liked'
  skip_before_action :logged_in_user, only: %i[new create]
  before_action :set_user, only: %i[edit update show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_url, notice: '招待メールを送りました。確認してください'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_url, notice: t('common.flash.updated')
    else
      flash.now[:alert] = @user.errors.full_messages.join('。')
      render :edit
    end
  end

  def show
    @articles = if liked_request?
                  Article.where(id: @user.likes.select(:article_id)).order(created_at: :desc, id: :desc).page(params[:page])
                else
                  @user.articles.order(created_at: :desc, id: :desc).page(params[:page])
                end
  end

  def liked_request?
    params[:liked] == LIKED_REQUEST
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :profile_image, :password, :password_confirmation)
  end
end