require_relative '../spec_helper'
require_relative '../../app/models/higher_than_x_rule'

RSpec.describe HigherThanXRule do
	before do
		Timecop.freeze(Time.now)
	end

	after do
		Timecop.return
	end

	it 'returns a new reward when the new record purchase is greater then theshold' do
		default_constructed = HigherThanXRule.new
		new_record = { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 6, 1) }
		reward = default_constructed.apply(new_record)
		expect(reward).to eql( {reward_date: Time.now, reward_type: 'Next Purchase Free Reward'})
	end

	it 'doesnot return a new record when the new record purchase is less than threshold' do
		parameterized_constructed = HigherThanXRule.new(threshold: 2000)
		new_record = { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 6, 1) }
		reward = parameterized_constructed.apply(new_record)
		expect(reward).to be_nil
	end

end