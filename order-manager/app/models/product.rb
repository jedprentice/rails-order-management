class Product < ActiveRecord::Base
  attr_accessible :name, :price

  validates :name, :price, :presence => true
  validates :name, :uniqueness => {:case_sensitive => false}
end
