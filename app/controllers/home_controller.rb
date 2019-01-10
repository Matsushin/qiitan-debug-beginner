class HomeController < ApplicationController

  def index
    @q = Article.includes(:user).order(created_at: :desc, id: :desc).search(params[:q])
    @articles = @q.result.page(params[:page])
  end
end