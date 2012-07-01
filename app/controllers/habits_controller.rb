class HabitsController < ApplicationController

  def index
    @habits = Habit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @habits }
    end
  end

  def show
    @habit = Habit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @habit }
    end
  end

  def new
    @habit = Habit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @habit }
    end
  end

  def edit
    @habit = Habit.find(params[:id])
  end

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

  def destroy
    @habit = Habit.find(params[:id])
    @habit.destroy

    respond_to do |format|
      format.html { redirect_to(habits_url) }
      format.xml  { head :ok }
    end
  end
end
