class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_comment, only: [:check_permission, :edit, :update]
  before_action :check_permission, only: [:edit, :update]

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        @post.last_comment_id = @comment.id
        @post.last_comment_user_id = @comment.user_id
        if @post.save
          @comments = @post.comments
          format.js
        end
      else
        render(@post, alert: "comment created failed!!")
      end
    end
  end

  def edit
    @post = @comment.post
  end

  def update
    @post = @comment.post
    if @comment.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def check_permission
      @user = @comment.user
      unless current_user_has_ud_permission_to?(@user)
        redirect_to root_path, alert: "invalid action!"
      end
    end
end
