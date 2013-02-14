require 'test_helper'

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
    params = {:product => {:name => 'test create', :price => '1.99'}}
    post(:create, params, :type => :json)
    assert_response :success

    product = Product.where(:name => params[:product][:name]).first
    assert !product.nil?, 'Product should have been saved'
    assert !product.id.nil?, 'Product should have an ID'
    product.delete
  end

  test 'update' do
    params = {:id => products(:one).id, :product => {:price => '14.99'}}
    put(:update, params, :type => :json)

    product = Product.find(params[:id])
    assert_equal params[:product][:price], product.price.to_s, 'Product was not updated'
  end

  test 'delete' do
    product = Product.new(:name => 'test delete', :price => '1.99')
    product.save

    delete(:destroy, {:id => product.id}, :type => :json)
    
    begin
      Product.find(product.id)
      product.delete
      fail 'Product should have been deleted'
    rescue
      # Expected
    end
  end
end
