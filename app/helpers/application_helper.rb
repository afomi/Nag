module ApplicationHelper

  def logged_in?
    session[:ryan]
  end

  def markdown(string)
    GitHub::Markdown.render_gfm(string)
  end

end
