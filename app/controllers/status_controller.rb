class StatusController < ApplicationController

  def edit
    session[:status] = params[:id].to_s
    Checkin.new()
    #redirect_to :controller => "checkins", :action => "new", :session => session
    redirect_to root_url, :session => session
  end

end
