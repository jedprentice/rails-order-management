require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'save duplicate name' do
    assert_invalid_save Product.new(:name => products(:one).name), 2
  end

  test 'save empty name' do
    assert_invalid_save Product.new(:price => 1.00), 2
  end

  test 'save empty price' do
    assert_invalid_save Product.new(:name => 'test save empty price'), 2
  end
end
