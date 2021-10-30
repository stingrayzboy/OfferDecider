# frozen_string_literal: true

require_relative './models'

# Setup the backend for the entire project.
class Backend
  attr_accessor :rules_list, :customer_purchases

  def initialize
    self.rules_list = []
    self.customer_purchases = []
    rules_list << HigherThanXRule.new
    rules_list << SecondPurchaseWithinXDaysRule.new
    rules_list << TodayIsCertainDayOfTheMonthRule.new
  end

  def get_reward(new_record)
    reward = nil
    rules_list.reverse.each do |rule|
      reward = rule.apply(new_record, existing_memory: customer_purchases)
      break unless reward.nil?
    end
    customer_purchases << new_record
    reward
  end
end
