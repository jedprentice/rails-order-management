class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def show_model(clazz)
    render :json => find_model(clazz)
  end

  def find_model(clazz)
    clazz.name.constantize.find(params[:id])
  end

  def create_model(clazz)
    save_model(clazz.name.constantize.new)
  end

  def update_model(clazz)
    save_model(find_model(clazz))
  end

  # TODO: This doesn't work for classes like LineItem => :line_item; fix
  def save_model(model)
    model.update_attributes!(params[model.class.name.downcase.to_sym])
    render :json => model
  end

  def destroy_model(clazz)
    clazz.name.constantize.destroy(params[:id])
    render :json => params[:id]
  end
end
