module ApplicationHelper

  def logged_in?
    session[:ryan]
  end

end
