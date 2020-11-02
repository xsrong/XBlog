class Node < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  has_many :posts, dependent: :destroy
end
