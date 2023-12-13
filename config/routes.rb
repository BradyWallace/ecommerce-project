Rails.application.routes.draw do
  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
    get "success", to: "checkout#success", as: "checkout_success"
  end

  resources :checkout, only: [:create], format: :js
  resources :cart, only: %i[index]
  get "/pages/:permalink" => "pages#permalink", as: "permalink"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]

  post "products/add_to_cart/:id", to: "products#add_to_cart", as: :add_to_cart

  delete "products/remove_from_cart/:id", to: "cart#remove_from_cart", as: :remove_from_cart

  root to: "products#index"
end
