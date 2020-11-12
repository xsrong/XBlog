class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, dependent: :destroy
  validates :content, presence: true

  def title
    self.post.title
  end

  def comments
    []
  end

  def received_likes
    Like.where("comment_id = ?", self.id)
  end

  def liked_by
    received_likes.map { |like| like.user_id }
  end

end
