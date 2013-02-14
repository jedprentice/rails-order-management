class OrdersController < ApplicationController
  def show
    show_model(Order)
  end

  def create
    create_model(Order)
  end

  def update
    update_model(Order)
  end
end
