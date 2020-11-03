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
    time = time_ago_in_words(post.updated_at)
    pre = updated?(post) ? "updated " : "created "
    pre + time + " ago."
  end

  def new_post?(post)
    (Time.now - post.created_at) / 3600 < 7 * 24
  end
end
