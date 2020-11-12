require 'redcarpet'
require 'coderay'
require 'font-awesome-rails'
module ApplicationHelper
  include HomeHelper
  include SessionsHelper
  include UsersHelper

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def initialize(ext={})
      ext = ext.merge({
        hard_wrap: true,
        filter_html: true,
      })
      super
    end

    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width => 2)
    end
  end

  def full_title(page_title='')
    t = "XBlog"
    t = "#{page_title} | " + t unless page_title.empty?
    t
  end

  def markdown(text)
    options = {   
      :autolink => true, 
      :space_after_headers => true,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :hard_wrap => true,
      :strikethrough => true,
      :disable_indented_code_blocks => true
    }
    renderer = Redcarpet::Markdown.new(HTMLwithCodeRay.new, options)
    # content_tag(:div, renderer.render(text), :class => "highlight ruby")
    renderer.render(text)
  end

  def html_tag_filter(text)
    text.gsub!(/<\/?.+?\/?>/, "")
  end
end


module FontAwesome
  module Rails
    module IconHelper
      def far_icon(names = "flag", original_options = {})
        options = original_options.deep_dup
        classes = ["far"]
        classes.concat Private.icon_names(names)
        classes.concat Array(options.delete(:class))
        text = options.delete(:text)
        right_icon = options.delete(:right)
        icon = content_tag(:i, nil, options.merge(:class => classes))
        Private.icon_join(icon, text, right_icon)
      end
    end
  end
end
