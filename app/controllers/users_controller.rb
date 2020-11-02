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
      format.js { render 'comments' }
    end
  end

  protected

  def set_user
    @user = User.find(params["id"])
  end
end
