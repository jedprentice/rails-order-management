class OrdersController < ApplicationController
  def show
    show_model(Order)
  end

  def create
    order = Order.new
    order.save
    render :json => order
  end

  def update
    update_model(Order)
  end
end
