class HomeController < ApplicationController
  def index
    @nodes = Node.all
    @posts = @nodes.map{ |node| Post.where("node_id = ?", node.id).limit(3).order(id: :desc) }
  end
end
