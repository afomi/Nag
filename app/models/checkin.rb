class Checkin < ActiveRecord::Base

  require 'nokogiri'

  before_save :check_for_habits

  def self.today
    Checkin.where("created_at >= ?", Date.today.midnight).order("created_at ASC")
  end

  def self.latest(n = 10)
    Checkin.where("created_at < ?", Date.today).order("created_at DESC").limit(n)
  end

  def created_at
    # adjust timezone
    #super - 7.hours if super
    super - 8.hours if super # for daylight savings
  end

  private

  def check_for_habits
    Nokogiri::HTML(self.text).css("habit").each do |habit|
      Habit.create(:description => habit.text)
    end
  end

end
