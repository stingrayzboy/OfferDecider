# frozen_string_literal: true

require 'date'

# Reward if the purchase date matches a special date.
class TodayIsCertainDayOfTheMonthRule
  attr_accessor :day, :month

  def initialize(threshold: nil)
    self.day = threshold.nil? ? 4 : threshold[:day]
    self.month = threshold.nil? ? 5 : threshold[:month]
  end

  def apply(new_record, existing_memory: [])
    date = new_record[:created_at]
    reward = nil
    if date.day == day && date.month == month
      reward = { reward_date: Time.now, reward_type: 'Star Wars themed item added to delivery' }
    end
    reward
  end
end
