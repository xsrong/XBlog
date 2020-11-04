module PostsHelper
  def display_limited_content(post, limit=20)
    if post.content.size <= limit
      content = post.content
    else
      content = post.content[0..limit] + "..."
    end
    html_tag_filter(markdown(content))
  end

  def updated?(post)
    post.created_at != post.updated_at
  end

  def display_newest_timestamp(post)
    unless post.comments.last.nil?
      time = time_ago_in_words(post.comments.last.created_at)
      res = link_to(post.comments.last.user.nickname, post.comments.last.user).prepend("last commented by ").concat(" " + time + " ago.")
    else
      time = time_ago_in_words(post.updated_at)
      if post.is_a?(Comment)
        res = time + " ago."
      else
        if post.updated_at == post.created_at
          pre = "created by "   
        else
          pre = "updated by "
        end
        res = link_to(post.user.nickname, post.user).prepend(pre).concat(" " + time + " ago.")
      end
    end
    res
  end

  def new_post?(post)
    (Time.now - post.created_at) / 3600 < 7 * 24
  end
end
