# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../app/models/today_is_certain_day_of_the_month_rule'

RSpec.describe TodayIsCertainDayOfTheMonthRule do
  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  it 'returns a new reward when the purchase date is 4th may' do
    default_constructed = TodayIsCertainDayOfTheMonthRule.new
    new_record = { customer_id: 65, purchase_amount_cents: 1600, created_at: Time.utc(2011, 5, 4, 11, 1) }
    reward = default_constructed.apply(new_record)
    expect(reward).to eql({ reward_date: Time.now, reward_type: 'Star Wars themed item added to delivery' })
  end

  it 'returns nil for date not in the declared special day' do
    parameterized_constructed = TodayIsCertainDayOfTheMonthRule.new(threshold: { day: 7, month: 11 })
    new_record = { customer_id: 65, purchase_amount_cents: 1600, created_at: Time.utc(2011, 5, 4, 11, 1) }
    reward = parameterized_constructed.apply(new_record)
    expect(reward).to be_nil
  end
end
