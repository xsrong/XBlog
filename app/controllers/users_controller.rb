class UsersController < ApplicationController
  before_action :set_user, only: [:info, :comments_list]

  def info
    @posts = @user.posts.order(id: :desc)
    respond_to do |format|
      format.html{ render 'info' }
      format.js
    end
  end

  def comments_list
    @comments = @user.comments.order(id: :desc)
    respond_to do |format|
      format.js { render 'users/comments' }
    end
  end

  def search
    @nicknames = User.where("nickname like ? ", "%#{params[:q]}%").limit(8).map { |user| user.nickname }
    render 'json': @nicknames
  end

  protected

  def set_user
    @user = User.find_by(nickname: params[:nickname])
  end
end
