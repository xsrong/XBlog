module PostsHelper
  def display_limited_content(post, limit=20)
    content = post.content
    content = html_tag_filter(markdown(content))
    content.size > limit ? content[0..limit] + "..." : content
  end

  def updated?(post)
    post.created_at != post.updated_at
  end

  def display_newest_timestamp(obj)
    # if obj.is_a?(Comment)
    #   time = time_ago_in_words(obj.created_at)
    #   res = link_to(obj.user_nickname, "/users/#{obj.user_nickname}").prepend("created by ").concat(" " + time + " ago.")
    # elsif obj.is_a?(Post)
    #   pre = "created by "   
    #   time = time_ago_in_words(obj.created_at)
    #   res = link_to(obj.user_nickname, "/users/#{obj.user_nickname}").prepend(pre).concat(" " + time + " ago.")
    # end
    time_ago_in_words(obj.created_at) + " ago"
  end

  def new_post?(post)
    (Time.now - post.created_at) / 3600 < 7 * 24
  end
end
