class Checkin < ActiveRecord::Base

  require 'nokogiri'

  scope :desc, -> { order("created_at DESC") }

  before_save :check_for_habits

  def self.today
    Checkin.where("created_at >= ?", Date.today.midnight + 8.hours).desc
  end

  def self.latest(n = 10)
    Checkin.where("created_at < ?", Date.today + 8.hours).desc.limit(n)
  end

  def created_at
    # adjust timezone
    #super - 7.hours if super
    super - 8.hours if super # for daylight savings
  end

  private

  def check_for_habits
    Nokogiri::HTML(self.text).css("habit").each do |habit|
      Habit.create(description: habit.text)
    end
  end

end
