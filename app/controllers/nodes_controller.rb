class NodesController < ApplicationController
  before_action :set_node, only: [:show]
  before_action :check_permission, only: [:new, :create]
  def show
    @posts = @node.posts.order(id: :desc)
  end

  def new
    @node = Node.new
  end

  def create
    @node = Node.new(node_params)
    if @node.save!
      redirect_to @node, notice: "created node successfully!"
    else
      render 'new'
    end
  end

  private
    def set_node
      @node = Node.find(params[:id])
    end

    def node_params
      params.require(:node).permit(:name)
    end

    def check_permission
      unless admin?(current_user)
        redirect_to root_path, notice: "invalid action!!"
      end
    end
end
