require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'save duplicate name' do
    check_bad_save Product.new(:name => products(:one).name)
  end

  test 'save empty name' do
    check_bad_save Product.new(:price => 1.00)
  end

  test 'save empty price' do
    check_bad_save Product.new(:name => 'test save empty price')
  end
  
  private

  def check_bad_save(product)
    product.save
    assert_equal 2, Product.count, 'Wrong number of products'
  end
end
