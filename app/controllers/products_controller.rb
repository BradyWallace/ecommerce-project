class ProductsController < ApplicationController
  def index
    if params["category"].blank? || params["category"]["id"].blank?
      @products = Product.all
    else
      category = Category.find(params["category"]["id"])
      @products = category.products
    end
    @products = @products.search(params[:keywords])
  end

  def show
    @product = Product.find(params[:id])
  end
end
