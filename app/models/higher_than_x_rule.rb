# frozen_string_literal: true

# Rule to give next order free if purchase made more than 1500 Cents.
class HigherThanXRule
  attr_accessor :threshold

  def initialize(threshold: nil)
    self.threshold = (threshold.nil? ? 1500 : threshold)
  end

  def apply(new_record, existing_memory: [])
    reward = nil
    if new_record[:purchase_amount_cents] > threshold
      reward = { reward_date: Time.now, reward_type: 'Next Purchase Free Reward' }
    end
    reward
  end
end
