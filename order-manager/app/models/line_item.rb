class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity

  belongs_to :order, :inverse_of => :line_items
  belongs_to :product

  validate :quantity_greater_than_zero

  private

  def quantity_greater_than_zero
    if quantity.nil? || quantity < 1
      errors.add(:quantity, 'Must be greater than zero')
    end
  end
end
