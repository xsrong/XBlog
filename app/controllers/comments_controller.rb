class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        @post.last_comment_id = @comment.id
        @post.last_comment_user_id = @comment.user_id
        @post.save
        @comments = @post.comments
        format.js
      else
        render(@post, alert: "comment created failed!!")
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def update
    @comment = Comment.find(params[:id])
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
end
