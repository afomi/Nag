class Checkin < ActiveRecord::Base

  require 'nokogiri'

  before_save :check_for_habits

  def self.hundred_latest
    Checkin.all(:limit => 100, :order => "created_at DESC")
  end

  def created_at
    # adjust timezone
    super - 7.hours if super
  end

  private

  def check_for_habits
    Nokogiri::HTML(self.text).css("habit").each do |habit|
      Habit.create(:description => habit.text)
    end
  end

end
