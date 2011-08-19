require 'test_helper'

class BuyerTest < ActiveSupport::TestCase
  test "should not save buyer without name" do
    buyer = Buyer.new
    assert !buyer.save
  end
end

