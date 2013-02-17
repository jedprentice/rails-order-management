require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test 'show' do
    expected = orders(:placed)
    get :show, {:id => expected.id}
    assert_response :success

    object = parse_response
    assert_equal expected.status, object['status'], 'Wrong status'
  end

  test 'create' do
    post(:create, {}, :type => :json)
    assert_response :success

    order = Order.find_by_status(Order::DRAFT)
    assert !order.nil?, 'Order should have been saved'
    assert !order.id.nil?, 'Order should have an ID'
    order.delete
  end

  test 'update' do
    params = {
      :id => orders(:placed).id,
      :order => {
        :order_date => Time.now,
        :vat => Rails.application.config.vat,
        :status => Order::CANCELLED,
        :notes => 'Order cancelled',
      }
    }

    put(:update, params, :type => :json)
    order = Order.find(params[:id])
    assert_equal params[:order][:order_date].to_i, order.order_date.to_i, 'Date was not updated'
    assert_equal params[:order][:status], order.status, 'Status was not updated'
    assert_equal params[:order][:notes], order.notes, 'Notes were not updated'
  end
end
