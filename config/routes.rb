Rails.application.routes.draw do
  get "/pages/:permalink" => "pages#permalink", as: "permalink"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]

  root to: "products#index"
end
