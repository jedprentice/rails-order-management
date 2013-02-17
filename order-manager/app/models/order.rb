class StatusValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    puts "\nvalidate_each: #{attribute} '#{record.status_was}' to '#{value}'\n"
    if record.status_was == Order::DRAFT
      next_statuses = [Order::PLACED, Order::CANCELLED]
      unless next_statuses.include?(value)
        record.errors.add(attribute, "#{self.status_was} can only go to #{next_statuses}")
        return
      end
      if value == Order::PLACED && (record.line_items.nil? || record.line_items.empty?)
        record.errors.add(attribute, 'Order must have line items to go from draft to placed')
        return
      end
    end
  end
end

class Order < ActiveRecord::Base
  include ActiveModel::Validations
  
  DRAFT = 'Draft'
  PLACED = 'Placed'
  PAID = 'Paid'
  CANCELLED = 'Cancelled'

  attr_accessible :notes, :order_date, :status, :vat, :line_items

  has_many :line_items, :inverse_of => :order

  validates :order_date, :vat, :presence => true
  validates_inclusion_of :status, :in => [DRAFT, PLACED, PAID, CANCELLED]
  validates :status, :presence => true, :status => true

  after_initialize :set_defaults

  private

  def set_defaults
    if new_record?
      self.order_date = Time.now
      self.status = DRAFT
      self.vat = Rails.application.config.vat
    end
  end
end
