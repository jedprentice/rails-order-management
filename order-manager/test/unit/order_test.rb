require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'after_initialize new' do
    order = Order.new
    assert_equal Order::DRAFT, order.status, 'Wrong status'
    assert_not_nil order.order_date, 'Order date should be initialized'
    assert_equal Rails.application.config.vat, order.vat, 'Wrong vat'
  end

  test 'after_initialize existing' do
    expected = orders(:one)
    order = Order.find(expected.id)
    assert_equal expected.status, order.status, 'Wrong status'
    assert_equal expected.order_date, order.order_date, 'Wrong order date'
    assert_equal expected.vat, order.vat, 'Wrong vat'
  end

  test 'validate order date' do
    check_validate_presence(:order_date)
  end

  test 'validate vat' do
    check_validate_presence(:vat)
  end

  test 'validate status inclusion of' do
    order = Order.new
    order.status = 'bad'
    assert_invalid order, :status
  end

  test 'validate status draft-to-placed' do
    order = Order.new
    order.status = Order::PLACED
    assert_invalid order, :status

    order.line_items << LineItem.new(:order => order, :product => products(:one), :quantity => 1)
    assert order.valid?, 'Order should be valid'
  end

#  test 'validate draft-to-cancelled' do
#    order = Order.new
#    order.status = Order::CANCELLED
#    assert_invalid order, :status
#
#    order.notes = 'Order cancelled in test_validate_draft_to_cancelled'
#    assert_valid order
#  end
#
#  test 'validate placed-to-cancelled' do
#    order = Order.new(:status => Order::PLACED)
#    order.line_items << LineItem.new(:order => order, :product => products(:one), :quantity => 1)
#    assert_valid order
#
#    order.status = Order::CANCELLED
#    assert_invalid order, :status
#
#    order.notes = 'Order cancelled in test_validate_draft_to_cancelled'
#    assert_valid order
#  end

  private

  def check_validate_presence(attr)
    order = Order.find(orders(:one).id)
    order[attr] = nil
    assert_invalid order, attr
  end

  def assert_valid(order)
    assert order.valid?, "#{order} should be valid"
  end
end
