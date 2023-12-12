class ProductsController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def index
    if params["category"].blank? || params["category"]["id"].blank?
      @products = Product.all
    else
      category = Category.find(params["category"]["id"])
      @products = category.products
    end
    @products = @products.search(params[:keywords])
    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0  # Set quantity to 1 if not provided or invalid
    session[:cart][id] ||= 0
    session[:cart][id] += quantity
    redirect_to cart_index_path
  end

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def load_cart
    @cart = Product.find(session[:cart].keys)
  end
end
