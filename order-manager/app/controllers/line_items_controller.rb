class LineItemsController < ApplicationController
  def show
    show_model(LineItem)
  end

  def create
    order = Order.find(params[:line_item][:order][:id])
    product = find_product
    line_item = LineItem.new(:order => order, :product => product,:quantity => params[:line_item][:quantity])
    line_item.save
    render :json => line_item
  end

  def update
    line_item = find_model(LineItem)
    puts line_item.attributes
    if line_item.product.id != params[:line_item][:product][:id]
      line_item.product = find_product
    end
    line_item.quantity = params[:line_item][:quantity]
    save(line_item)
  end

  def destroy
    destroy_model(LineItem)
  end

  private

  def save(line_item)
    line_item.save
    render :json => line_item
  end

  def find_product
    Product.find(params[:line_item][:product][:id])
  end
end
