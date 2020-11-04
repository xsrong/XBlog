class HomeController < ApplicationController
  def index
    @nodes = Node.all
    @posts = @nodes.map{ |node| Post.where("node_id = ?", node.id).order(last_comment_id: :desc).limit(3) }
  end
end
