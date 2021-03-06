require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  test 'show' do
    expected = line_items(:one)
    get :show, {:id => expected.id}
    assert_response :success

    object = parse_response
    assert_equal expected.quantity, object['quantity'], 'Wrong quantity'
  end

  test 'create' do
    params = {
      :line_item => {
        :order => {:id => orders(:placed).id},
        :product => {:id => products(:one).id},
        :quantity => 5
      }
    }
    post(:create, params, :type => :json)
    assert_response :success

    line_item = LineItem.find_by_quantity(5)
    assert !line_item.nil?, 'Line item should have been saved'
    assert !line_item.id.nil?, 'Line item should have an ID'
    line_item.delete
  end

  test 'update' do
    line_item = line_items(:one)
    params = {
      :id => line_item.id,
      :line_item => {:quantity => 2}
    }

    put(:update, params, :type => :json)
    line_item = LineItem.find(params[:id])
    assert_equal params[:line_item][:quantity].to_i, line_item.quantity, 'Quantity was not updated'
  end

  test 'destroy' do
    line_item = LineItem.new(:order => orders(:placed), :product => products(:one), :quantity => 5)
    line_item.save

    delete(:destroy, {:id => line_item.id}, :type => :json)

    begin
      LineItem.find(line_item.id)
      line_item.delete
      fail 'Line item should have been deleted'
    rescue
      # Expected
    end
  end
end
