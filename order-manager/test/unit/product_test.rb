require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'save duplicate name' do
    assert_invalid Product.new(:name => products(:one).name), :name
  end

  test 'save empty name' do
    assert_invalid Product.new(:price => 1.00), :name
  end

  test 'save empty price' do
    assert_invalid Product.new(:name => 'test save empty price'), :price
  end

  test 'destroy ordered product' do
    begin
      Product.destroy(products(:one).id)
      fail 'Product should not have been destroyed'
    rescue
      # Expected
    end
  end
end
