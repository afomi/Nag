class CheckinsController < ApplicationController

  before_filter :public, :except => :just_login

  def index
    @checkins = Checkin.hundred_latest

    respond_to do |format|
      format.html
      format.xml { render :xml => @checkins }
    end
  end

  def public
    render "public" unless session[:ryan]
  end

  def just_login
    session["ryan"] = true
    redirect_to root_path
  end

  def logout
    session.clear
    redirect_to root_path
  end

  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => @checkin }
    end
  end

  def new
    @todays_checkins = Checkin.today

    @latest_checkins = Checkin.latest
    @checkin         = Checkin.new

    require 'open-uri'

    gparams = "?start-min=#{(DateTime.now).to_s}"
    gparams << "&start-max=#{(DateTime.now + 6.months).to_s}"
    gparams << "&orderby=starttime"

    gcal_base_url = "https://www.google.com/calendar/feeds/"

    @refresh = (params[:refresh] ||= false)

    @url  = "#{gcal_base_url}andria.williams%40gmail.com/private-66e0674cd72ec792be8548356a87808d/full#{gparams}"
    name  = "andria_cal.xml"
    @url2 = "#{gcal_base_url}ryanjwold%40gmail.com/private-66728cb6cd63fbe9de7b7550c9bb24c9/full#{gparams}"
    name2 = "ryan_cal.xml"

    if File.exist?("#{Rails.root}/tmp/#{name}") and (Time.now - 2.days < File.ctime("#{Rails.root}/tmp/#{name}")) and !@refresh
      logger.debug("Fetching local #{name}")
      @calendar_xml = File.open("#{Rails.root}/tmp/#{name}", "r").read
    else
      logger.debug("Fetching #{@url}")
      @calendar_xml = open(@url).read
      File.open("#{Rails.root}/tmp/#{name}", "w") do |f|
        f << @calendar_xml
      end
    end

    if File.exist?("#{Rails.root}/tmp/#{name2}") and (Time.now - 2.days < File.ctime("#{Rails.root}/tmp/#{name2}")) and !@refresh
      logger.debug("Fetching local #{name2}")
      @calendar_xml2 = File.open("#{Rails.root}/tmp/#{name2}", "r").read
    else
      logger.debug("Fetching #{@url2}")
      @calendar_xml2 = open(@url2).read
      File.open("#{Rails.root}/tmp/#{name2}", "w") do |f|
        f << @calendar_xml2
      end
    end

    doc             = Nokogiri::XML(@calendar_xml)
    @shared_entries = doc.css("entry").sort_by { |e| DateTime.parse(e.xpath("gd:when")[0]["startTime"]) }[0..9]

    doc2          = Nokogiri::XML(@calendar_xml2)
    @ryan_entries = doc2.css("entry").sort_by { |e| t = e.xpath("gd:when"); t2 = t[0]; t3 = t2["startTime"] rescue Time.now.to_s; DateTime.parse(t3) }[0..9]

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
