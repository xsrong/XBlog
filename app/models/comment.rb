class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true

  def title
    self.post.title
  end

  def comments
    []
  end
end
