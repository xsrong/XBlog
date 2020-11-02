class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        @comments = @post.comments
        format.js
      else
        render(@post, alert: "comment created failed!!")
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
