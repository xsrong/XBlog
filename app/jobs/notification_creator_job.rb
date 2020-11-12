class NotificationCreatorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    noti = Notification.new(args[0])
    noti.save
  end
end
