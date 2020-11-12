class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where("mentioned_user_id = ?", current_user.id).order(id: :desc)
    render 'users/notifications'
  end
end
