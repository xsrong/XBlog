class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :preview]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :check_permission]
  before_action :check_permission, only: [:edit, :update, :destroy]

  def new
    @nodes = Node.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @author = User.find(@post.user_id)
    @node = Node.find(@post.node_id)
    @comments = @post.comments
  end

  def edit
    @nodes = Node.all
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to @user, notice: "post deleted successfully!!"
  end

  def preview
    @source = params["source"]
    respond_to do |format|
      format.json
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :node_id)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def check_permission
      @user = @post.user
      unless current_user_has_ud_permission_to?(@user)
        redirect_to root_path, alert: "invalid action!"
      end
    end
end
