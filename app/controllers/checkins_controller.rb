class CheckinsController < ApplicationController

  def index
    @checkins = Checkin.hundred_latest

    respond_to do |format|
      format.html
      format.xml { render :xml => @checkins }
    end
  end

  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => @checkin }
    end
  end

  def new
    @checkins     = Checkin.all(:limit => 10, :order => "created_at DESC")

    @checkin = Checkin.new

    respond_to do |format|
      format.html
      format.xml { render :xml => @checkin }
    end
  end

  def edit
    @checkin = Checkin.find(params[:id])
  end

  def create
    @checkin = Checkin.new(params[:checkin])

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to(new_checkin_path, :notice => 'Checkin was successfully created.') }
        format.xml { render :xml => @checkin, :status => :created, :location => @checkin }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to(@checkin, :notice => 'Checkin was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to(checkins_url) }
      format.xml { head :ok }
    end
  end

  # this controller method is designed to provide Nag data in a format
  # readable by Simile timeline library
  def data
    @checkins                  = Checkin.hundred_latest
    @simile_formatted_checkins = []

    @checkins.each do |checkin|
      @simile_formatted_checkins << {
          :title         => DateTime.parse(checkin["created_at"].to_s).strftime("%b %d at %I:%M %P"),
          :start         => checkin["created_at"],
          :description   => checkin["text"],
          :image         => "",
          :link          => "",
          :durationEvent => false
      }
    end

    payload = {
        'dateTimeFormat' => 'iso8601',
        'wikiURL'        => "http://afomi.com",
        'wikiSection'    => @settings[:timeline][:wiki_section],
        "events"         => @simile_formatted_checkins
    }
    render :json => payload
  end
end
