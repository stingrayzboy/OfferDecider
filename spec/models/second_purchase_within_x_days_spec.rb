require_relative '../spec_helper'
require_relative '../../app/models/second_purchase_within_x_days_rule'

RSpec.describe SecondPurchaseWithinXDaysRule do
  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  subject { SecondPurchaseWithinXDaysRule.new }

  it 'returns no reward for no existing memory' do
    new_record = { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 6, 1) }
    reward = subject.apply(new_record)
    expect(reward).to be_nil
  end

  it 'returns no reward for existing memory beyond 30 days' do
    new_record = { customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2009, 1, 2, 6, 1) }
    existing_memory = [{ customer_id: 65, purchase_amount_cents: 1800, created_at: Time.utc(2008, 1, 2, 6, 1) }]
    reward = subject.apply(new_record, existing_memory: existing_memory)
    expect(reward).to be_nil
  end
end
