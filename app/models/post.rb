class Post < ApplicationRecord
  belongs_to :user
  belongs_to :node
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :title, presence: true, length: {maximum: 255}
  validates :content, presence: true


  def post
    self
  end

  def post_id
    self.id
  end

  def received_likes
    Like.where("post_id = ?", self.id)
  end

  def liked_by
    received_likes.map { |like| like.user_id }
  end
end
