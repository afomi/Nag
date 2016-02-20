class TouchpointsController < ApplicationController

  before_filter :log_session

  def log_session
    puts request.inspect
  end

  def index
    @touchpoints = Touchpoint.all

    respond_to do |format|
      format.html
      format.json { render json: @touchpoints }
    end
  end

  def show
    @touchpoint = Touchpoint.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @touchpoint }
    end
  end

  def new
    @touchpoint = Touchpoint.new

    respond_to do |format|
      format.html
      format.json { render json: @touchpoint }
    end
  end

  def edit
    @touchpoint = Touchpoint.find(params[:id])
  end

  def create
    @touchpoint = Touchpoint.new(params[:touchpoint])
    puts @touchpoint.inspect

    respond_to do |format|
      if @touchpoint.save
        format.html { redirect_to(@touchpoint, :notice => 'Touchpoint was successfully created.') }
        format.xml { render :xml => @touchpoint, :status => :created, :location => @touchpoint }
        format.json { render :json => @touchpoint, :status => :created, :location => @touchpoint }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @touchpoint.errors, :status => :unprocessable_entity }
        format.json { render :json => @touchpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /touchpoints/1
  # PUT /touchpoints/1.xml
  def update
    @touchpoint = Touchpoint.find(params[:id])

    respond_to do |format|
      if @touchpoint.update_attributes(params[:touchpoint])
        format.html { redirect_to(@touchpoint, :notice => 'Touchpoint was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @touchpoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /touchpoints/1
  # DELETE /touchpoints/1.xml
  def destroy
    @touchpoint = Touchpoint.find(params[:id])
    @touchpoint.destroy

    respond_to do |format|
      format.html { redirect_to(touchpoints_url) }
      format.xml { head :ok }
    end
  end
end
