class CheckoutController < ApplicationController
  def create
    product_ids = params[:product_ids]
    @products = Product.where(id: product_ids)
    @province = Province.find(params[:province]["id"])

    session[:checkout_products] = @products.map(&:id)
    session[:province] = @province.id

    @gst_rate = @province.gst
    @pst_rate = @province.pst
    @hst_rate = @province.hst

    line_items = @products.map do |product|
      [
        {
          price_data: {
            currency:     "cad",
            product_data: {
              name:        product.name,
              description: product.descrption
            },
            unit_amount:  product.price.to_i
          },
          quantity:   session[:cart][product.id.to_s].to_i
        },
        {
          price_data: {
            currency:     "cad",
            product_data: {
              name:        "GST",
              description: "Goods and Services Tax"
            },
            unit_amount:  (product.price * @gst_rate).to_i
          },
          quantity:   session[:cart][product.id.to_s].to_i
        },
        {
          price_data: {
            currency:     "cad",
            product_data: {
              name:        "PST",
              description: "Provincial Sales Tax"
            },
            unit_amount:  (product.price * @pst_rate).to_i
          },
          quantity:   session[:cart][product.id.to_s].to_i
        },
        {
          price_data: {
            currency:     "cad",
            product_data: {
              name:        "HST",
              description: "Harmonized Sales Tax"
            },
            unit_amount:  (product.price * @hst_rate).to_i
          },
          quantity:   session[:cart][product.id.to_s].to_i
        }
      ]
    end.flatten

    total = line_items.sum { |item| item[:price_data][:unit_amount] * item[:quantity] }
    tax_amount = line_items.sum { |item| item[:price_data][:unit_amount] * item[:quantity] * (@gst_rate + @pst_rate + @hst_rate) }

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      mode:                 "payment",
      line_items:,
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    product_ids = session[:checkout_products]
    @products = Product.where(id: product_ids)

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    if @products.present?
      # Calculate total based on the Stripe session
      total = @session.amount_total / 100.0

      # Fetch the customer's province and associated tax rates
      prov_id = session[:province]
      province = Province.find(prov_id)
      gst_rate = province.gst
      pst_rate = province.pst
      hst_rate = province.hst

      # Calculate the total tax amount based on the sum of tax rates
      tax_rate = gst_rate + pst_rate + hst_rate
      tax_amount = total * tax_rate

      @order = Order.create(
        order_num:  params[:session_id],
        total:,
        tax_amount:,
        order_date: Date.current
      )
      # Associate products with the order
      @products.each do |product|
        order_item = @order.order_items.build(product:, quantity: session[:cart][product.id.to_s].to_i)
        order_item.price = product.price
        order_item.save
      end
      session.delete(:cart)
    end
    session.delete(:checkout_products)
    session.delete(:province)
  end

  def cancel; end

  private

  def load_cart
    @cart = Product.find(session[:cart].keys)
  end
end
