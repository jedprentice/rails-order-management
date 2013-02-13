class Order < ActiveRecord::Base
  DRAFT = 'Draft'
  PLACED = 'Placed'
  PAID = 'Paid'
  CANCELLED = 'Cancelled'

  attr_accessible :notes, :order_date, :status, :vat

  validates :order_date, :vat, {:presence => true}
  validates_inclusion_of :status, :in => [DRAFT, PLACED, PAID, CANCELLED]

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
