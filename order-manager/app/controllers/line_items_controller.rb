class LineItemsController < ApplicationController
  def show
    show_model(LineItem)
  end

  def create
    create_model(LineItem)
  end

  def update
    update_model(LineItem)
  end

  def destroy
    destroy_model(LineItem)
  end
end
