class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 100 }
  before_create :set_default_role

  def set_default_role
    self.role = :user
  end
end
