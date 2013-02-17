class StatusValidator < ActiveModel::EachValidator
  def initialize(options)
    super
    @validations = [:ensure_valid_transition, :ensure_line_items_present, :ensure_notes_present]
  end

  def validate_each(record, attribute, value)
    @validations.each do |validation|
      if record.errors.empty?
        self.send(validation, record, attribute, value)
      end
    end
  end

  private

  def ensure_valid_transition(record, attribute, value)
    available_transitions = transitions_for(record.status_was)
    unless record.status_was == value || available_transitions.include?(value)
      record.errors.add(attribute, "#{record.status_was} can only go to #{available_transitions}")
    end
  end

  def ensure_line_items_present(record, attribute, value)
    if value == Order::PLACED && (record.line_items.nil? || record.line_items.empty?)
      record.errors.add(attribute, 'Order must have line items to go from draft to placed')
    end
  end

  def ensure_notes_present(record, attribute, value)
    if value == Order::CANCELLED && record.notes.blank?
      record.errors.add(attribute, 'A note must be added to cancel')
    end
  end

  def transitions_for(status)
    if status == Order::DRAFT
      [Order::PLACED, Order::CANCELLED]
    elsif status == Order::PLACED
      [Order::PAID, Order::CANCELLED]
    else
      []
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
