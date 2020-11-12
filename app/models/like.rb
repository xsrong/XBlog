class Like < ApplicationRecord
  belongs_to :user

  def post
    Post.find(self.post_id)
  end

  def comment
    Comment.find(self.comment_id)
  end
end
