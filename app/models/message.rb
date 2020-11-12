class Message < ApplicationRecord
  validates :content, presence: true

  def from_user
    User.find(self.from_user_id)
  end

  def to_user
    User.find(self.to_user_id)
  end

end
