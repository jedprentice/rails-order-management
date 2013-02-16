class Order < ActiveRecord::Base
  DRAFT = 'Draft'
  PLACED = 'Placed'
  PAID = 'Paid'
  CANCELLED = 'Cancelled'

  attr_accessible :notes, :order_date, :status, :vat, :line_items

  has_many :line_items, :inverse_of => :order

  validates :order_date, :vat, :presence => true
  validates_inclusion_of :status, :in => [DRAFT, PLACED, PAID, CANCELLED]
  validate :ensure_valid_status, :if => :status_changed?

  after_initialize :set_defaults

  private

  def set_defaults
    if new_record?
      self.order_date = Time.now
      self.status = DRAFT
      self.vat = Rails.application.config.vat
    end
  end

  def ensure_valid_status
    if self.status == PLACED && self.status_was == DRAFT && self.line_items.nil? || self.line_items.empty?
      errors.add(:status, 'Order must have line items to go from draft to placed')
      return
    end
  end 
end
