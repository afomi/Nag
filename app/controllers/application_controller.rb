class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :basic_settings

  def basic_settings
    @settings = {
        :user     => "Ryan",
        :timeline => {
            :wiki_section => "Ryan's Checkin Timeline'"
        }
    }
  end

  def monitor_status
    session[:status] = params[:id] if params[:action] == "monitor_status"
    redirect_to root_path
  end
end
