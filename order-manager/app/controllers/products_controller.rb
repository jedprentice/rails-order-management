class ProductsController < ApplicationController
  respond_to :json
  
  def index
    render :json => Product.find(:all)
  end

  def show
    show_model(Product)
  end

  def create
   create_model(Product)
  end

  def update
    update_model(Product)
  end

  def destroy
    destroy_model(Product)
  end
end
