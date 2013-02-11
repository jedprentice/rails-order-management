class ProductsController < ApplicationController
  def index
    render :json => Product.find(:all)
  end

  def show
    render :json => Product.find(params[:id])
  end
end
