module MarkdownHelper
  YOUTUBE_URL_RE = %r{https?://(?:www\.)?(?:youtube\.com/watch\?v=|youtu\.be/|youtube\.com/embed/)([a-zA-Z0-9_-]+)[^\s<]*}

  def render_markdown(text)
    return "" if text.blank?

    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer,
      autolink: true,
      tables: true,
      fenced_code_blocks: true
    )
    html = markdown.render(text)
    html = embed_youtube_videos(html)
    html.html_safe
  end

  private

  def embed_youtube_videos(html)
    html.gsub(%r{<a [^>]*href="#{YOUTUBE_URL_RE}"[^>]*>.*?</a>}m) do
      %(<lite-youtube videoid="#{$1}"></lite-youtube>)
    end
  end
end
