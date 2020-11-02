module ApplicationHelper
  include HomeHelper
  include SessionsHelper
  include UsersHelper

  def full_title(page_title='')
    t = "XBlog"
    t = "#{page_title} | " + t unless page_title.empty?
    t
  end
end
