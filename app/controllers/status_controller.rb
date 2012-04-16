class StatusController < ApplicationController

  def edit
    session[:status] = params[:id].to_s
    Checkin.new()
    #redirect_to :controller => "checkins", :action => "new", :session => session
    redirect_to root_url, :session => session
  end

  def update
    valid_attributes = ["app", "key", "value"]
    query = params.delete_if { |k, v| !valid_attributes.include?(k) }

    @stat = Stat.where(query)
    if @stat.length > 0
      @stat
    else
      stat = query
      @stat = Stat.create!(stat)
    end

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json
    end

  end

end
