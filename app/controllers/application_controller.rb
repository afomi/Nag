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
end
