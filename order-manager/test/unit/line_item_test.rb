require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test 'nonzero quantity' do
    line_item = line_items(:one)
    line_item.quantity = 0
    assert_invalid line_item, :quantity
  end
end
