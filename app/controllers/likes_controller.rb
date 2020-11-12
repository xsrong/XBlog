class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @like = Like.new
    case params[:data_type]
    when "post"
      @like.post_id = params[:data_id]
      @data = Post.find(params[:data_id])
      @like.comment_id = -1
    when "comment"
      @like.comment_id = params[:data_id]
      @data = Comment.find(params[:data_id])
      @like.post_id = -1
    end
    if @data.user_id == current_user.id || @like.post_id * @like.comment_id > 0 || @data.liked_by.include?(current_user.id)
      redirect_to @data.post, alert: "error occured!!"
    else
      @like.user_id = current_user.id
      @like.user_nickname = current_user.nickname
      # if @like.save
      #   @liked_by = @data.liked_by
      #   @btn = params[:f]
      #   @size = @btn =~ /post/ ? "fa-3x" : "fa-2x"
        noti_cont = <<-HTML
          <div class="notification">
            <a href="/users/#{current_user.nickname}">
              #{current_user.nickname}
            </a>
             likes your #{params[:data_type]} #{params[:data_type] == "post" ? "" : " in "}
            <a href="/posts/#{@data.post.id}">
              #{@data.title}
            </a>.
          </div>
        HTML
        # @noti = Notification.new({user_id: current_user.id, user_nickname: current_user.nickname, mentioned_user_id: @data.user_id, mentioned_user_nickname: @data.user_nickname, mentioned_data_type: params[:data_type], mentioned_data_id: params[:data_id], content: noti_cont})
        # @noti.save
        NotificationCreatorJob.perform_later({user_id: current_user.id, user_nickname: current_user.nickname, mentioned_user_id: @data.user_id, mentioned_user_nickname: @data.user_nickname, mentioned_data_type: params[:data_type], mentioned_data_id: params[:data_id], content: noti_cont})
        render 'create.js'
      # end
    end
  end

  def destroy
    case params[:data_type]
    when "post"
      @like = Like.where("user_id = ? AND post_id = ?", current_user.id, params[:data_id])[0]
      @data = Post.find(params[:data_id])
    when "comment"
      @like = Like.where("user_id = ? AND comment_id = ?", current_user.id, params[:data_id])[0]
      @data = Comment.find(params[:data_id])
    end
    if @like.destroy
      @liked_by = @data.liked_by
      @btn = params[:f]
      @size = @btn =~ /post/ ? "fa-3x" : "fa-2x"
      render 'create.js'
    end
  end

  private
    def like_params
      params.require(:likes).permit(:data_type, :data_id, :f)
    end
end
