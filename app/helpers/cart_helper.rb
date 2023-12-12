module CartHelper
  def calculate_pst(cart)
    subtotal = cart.sum { |product| product.price * (session[:cart][product.id.to_s] || 0) }

    # Get the tax rates for the customer's province
    pst_rate = 0.07

    # Calculate taxes based on the available tax rates
    taxes = 0.0

    taxes += subtotal * pst_rate if pst_rate > 0

    number_to_currency(taxes / 100)
  end

  def calculate_gst(cart)
    subtotal = cart.sum { |product| product.price * (session[:cart][product.id.to_s] || 0) }

    # Get the tax rates for the customer's province
    gst_rate = 0.05

    # Calculate taxes based on the available tax rates
    taxes = 0.0

    taxes += subtotal * gst_rate if gst_rate > 0

    number_to_currency(taxes / 100)
  end

  def calculate_hst(cart)
    subtotal = cart.sum { |product| product.price * (session[:cart][product.id.to_s] || 0) }

    # Get the tax rates for the customer's province
    hst_rate = 0

    # Calculate taxes based on the available tax rates
    taxes = 0.0

    taxes += subtotal * hst_rate if hst_rate > 0

    number_to_currency(taxes / 100)
  end

  def calculate_total_amount(cart)
    subtotal = cart.sum { |product| product.price * (session[:cart][product.id.to_s] || 0) }

    hst_rate = 0

    # Calculate taxes based on the available tax rates
    hst = 0.0

    hst += subtotal * hst_rate if hst_rate > 0

    gst_rate = 0.05

    # Calculate taxes based on the available tax rates
    gst = 0.0

    gst += subtotal * gst_rate if gst_rate > 0

    pst_rate = 0.07

    # Calculate taxes based on the available tax rates
    pst = 0.0

    pst += subtotal * pst_rate if pst_rate > 0

    total = subtotal + gst + pst + hst

    number_to_currency(total / 100)
  end
end
