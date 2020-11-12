class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:check_permission, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @comment.user_nickname = current_user.nickname
    respond_to do |format|
      if @comment.save
        @post.last_comment_id = @comment.id
        @post.last_comment_user_id = @comment.user_id
        @post.last_commented_at = @comment.created_at
        @post.last_comment_user_nickname = current_user.nickname
        if @post.save
          @comments = @post.comments
          unless current_user?(@post.user_id) 
            content = <<-HTML
              <div class="notification">
                <a href="/users/#{current_user.nickname}">
                  #{current_user.nickname} 
                </a>
                commented your post 
                <a href="/posts/#{@post.id}">
                  #{@post.title}
                </a>.
              </div>
            HTML
            @noti = Notification.new({user_id: current_user.id, user_nickname: current_user.nickname, mentioned_user_id: @post.user_id, mentioned_user_nickname: @post.user_nickname, mentioned_data_type: "posts", mentioned_data_id: params[:post_id], content: content})
            @noti.save
          end
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
      redirect_to "/posts/#{@comment.post_id}"
    else
      render 'edit'
    end
  end

  def destroy
    @post = @comment.post 
    respond_to do |format|
      if @comment.destroy
        if @post.last_comment_id == @comment.id
          new_last_comment = @post.comments[-2]
          @post.last_comment_id = new_last_comment&.id
          @post.last_comment_user_id = new_last_comment&.user_id
          @post.last_commented_at = new_last_comment&.created_at
          @post.last_comment_user_nickname = new_last_comment&.user.nickname
          @post.save
        end
        @comments = @post.comments
        format.js { render "create.js" }
      else
        render @post, alert: "comment destroy failed!!"
      end
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
      user_id = @comment.user_id
      unless current_user_has_ud_permission_to?(user_id)
        redirect_to root_path, alert: "invalid action!"
      end
    end
end
