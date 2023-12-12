class CartController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def index; end

  def remove_from_cart
    product_id = params[:id]
    session[:cart].delete(product_id)
    redirect_to cart_index_path, notice: "Product removed from cart."
  end

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def load_cart
    @cart = Product.find(session[:cart].keys)
  end
end
