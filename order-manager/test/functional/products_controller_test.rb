require 'test_helper'
require 'json'

class ProductsControllerTest < ActionController::TestCase
  test 'index' do
    get :index
    assert_response :success
    objects = parse_response
    assert_equal 2, objects.length, 'Wrong number of objects'
  end

  test 'show' do
    expected = products(:one)
    get :show, {:id => expected.id}
    assert_response :success

    object = parse_response
    assert_equal expected.name, object['name'], 'Wrong name'
    assert_equal expected.price.to_s, object['price'], 'Wrong price'
  end

  test 'create' do
    object = {:name => 'test create', :price => '1.99'}
    post(:save, object.to_json, :type => :json)
    assert_response :success

    product = Product.where(:name => object[:name]).first
    assert !product.nil?
    product.delete
  end

  private

  def parse_response
    JSON.parse(@controller.response.body)
  end
end
