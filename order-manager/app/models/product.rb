class Product < ActiveRecord::Base
  attr_accessible :name, :price

  validates :name, :price, :presence => true
  validates :name, :uniqueness => {:case_sensitive => false}

  before_destroy do |product|
    if LineItem.where(:product_id => product.id).exists?
      raise 'Product is associated with one or more orders'
    end
  end
end
