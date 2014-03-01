class CheckinsController < ApplicationController

  before_filter :public, :except => [:just_login, :tags]
  before_filter :refresh

  def index
    @checkins = Checkin.latest(30)

    respond_to do |format|
      format.html
      format.xml { render :xml => @checkins }
    end
  end

  def public
    render "public" unless session[:ryan]
  end

  def tags
    respond_to do |format|
      format.json { render :json => parse_tags(Checkin.today) }
    end
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
    require 'open-uri'

    @todays_checkins = Checkin.today
    @latest_checkins = Checkin.latest

    @checkin = Checkin.new
    @documents = Document.all(:order => "id")
    # Optionally enable extras by uncommenting the line below
    # extras
  end

  def edit
    @checkin = Checkin.find(params[:id])
  end

  def create
    @checkin = Checkin.new(params[:checkin])

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to(new_checkin_path, :notice => 'Checkin was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
        format.json { render :json => @checkin.errors, :status => :unprocessable_entity }
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


  private

  def refresh
    @refresh = params[:refresh] ||= nil
  end

  def parse_tags(recordset)
    recordset.collect(&:text).to_s.scan(/(?<=#)[[:alnum:]]+/)
  end

  def extras
    gcal_base_url = "https://www.google.com/calendar/feeds/"

    gparams = "?start-min=#{(DateTime.now).to_s}"
    gparams << "&start-max=#{(DateTime.now + 1.months).to_s}"
    gparams << "&orderby=starttime"

    url1  = "#{gcal_base_url}#{$google_calendar_1}#{gparams}"
    name1 = "cal1.xml"

    url2  = "#{gcal_base_url}#{$google_calendar_2}#{gparams}"
    name2 = "cal2.xml"

    @calendar_xml1 = try_cache(name1, url1)
    @calendar_xml2 = try_cache(name2, url2)

    doc      = Nokogiri::XML(@calendar_xml1).css("entry")
    doc2     = Nokogiri::XML(@calendar_xml2).css("entry")
    @entries = (doc + doc2).sort_by { |e| t = e.xpath("gd:when"); t2 = t[0]; t3 = t2["startTime"] rescue Time.now.to_s; DateTime.parse(t3) }[0..19]
  end

  # take a filename and url and will download the results and cache it
  def try_cache(name = "", url = "", options = { :refresh => @refresh, :xml => false })
    raise ArgumentError if url.empty?

    to_xml = options[:xml]

    @response = ""

    if File.exist?("#{Rails.root}/tmp/#{name}") and (Time.now - 2.days < File.ctime("#{Rails.root}/tmp/#{name}")) and !refresh
      logger.debug("Fetching local #{name}")
      @response = File.open("#{Rails.root}/tmp/#{name}", "r").read
    else
      logger.debug("Fetching #{url}")
      @response = open(url).read
      File.open("#{Rails.root}/tmp/#{name}", "w") do |f|
        f << @response
      end
    end

    if to_xml
      return Nokogiri::XML(@response)
    else
      return @response
    end
  end

end
