class ProductsController < ApplicationController
  respond_to :json
  
  def index
    render :json => Product.find(:all)
  end

  def show
    render :json => Product.find(params[:id])
  end

  def save
    product = Product.where(:id => params[:id]).first_or_create
    product.update_attributes!(params)
  end
end
