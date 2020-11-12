class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 100 }
  before_create :set_default_role

  def set_default_role
    self.role = :user
  end

  def sent_messages
    Message.where("from_user_id = ?", self.id)
  end

  def received_messages
    Message.where("to_user_id = ?", self.id)
  end

  def related_messages(other_user)
    Message.where("(from_user_id = ? AND to_user_id = ?) OR (from_user_id = ? AND to_user_id = ?)", self.id, other_user.id, other_user.id, self.id ).order(id: :desc)
  end

  def received_likes
    Like.where("to_user_id = ?", self.id).order(id: :desc)
  end

  def received_likes_count
    received_likes.count
  end

  def has_new_notification?
    !Notification.where("mentioned_user_id = ? AND read = ?", self.id, false).count.zero?
  end

end
