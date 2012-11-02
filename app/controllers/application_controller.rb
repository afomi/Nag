class ApplicationController < ActionController::Base
  protect_from_forgery

  load Rails.root + 'lib/afomi_extras.rb'

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
