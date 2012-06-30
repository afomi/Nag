class HabitsController < ApplicationController
  # GET /habits
  # GET /habits.xml
  def index
    @habits = Habit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @habits }
    end
  end

  # GET /habits/1
  # GET /habits/1.xml
  def show
    @habit = Habit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @habit }
    end
  end

  # GET /habits/new
  # GET /habits/new.xml
  def new
    @habit = Habit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @habit }
    end
  end

  # GET /habits/1/edit
  def edit
    @habit = Habit.find(params[:id])
  end

  # POST /habits
  # POST /habits.xml
  def create
    @habit = Habit.new(params[:habit])

    respond_to do |format|
      if @habit.save
        format.html { redirect_to(@habit, :notice => 'Habit was successfully created.') }
        format.xml  { render :xml => @habit, :status => :created, :location => @habit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @habit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /habits/1
  # PUT /habits/1.xml
  def update
    @habit = Habit.find(params[:id])

    respond_to do |format|
      if @habit.update_attributes(params[:habit])
        format.html { redirect_to(@habit, :notice => 'Habit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @habit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /habits/1
  # DELETE /habits/1.xml
  def destroy
    @habit = Habit.find(params[:id])
    @habit.destroy

    respond_to do |format|
      format.html { redirect_to(habits_url) }
      format.xml  { head :ok }
    end
  end
end
