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

  test 'validate status' do
    order = Order.new
    order.status = 'bad'
    assert_invalid order, :status
  end

  private

  def check_validate_presence(attr)
    order = Order.find(orders(:one).id)
    order[attr] = nil
    assert_invalid order, attr
  end
end
