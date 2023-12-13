ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :order_num, :total, :tax_amount, :order_date
  #
  # or
  #
  # permit_params do
  #   permitted = [:order_num, :total, :tax_amount, :order_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
