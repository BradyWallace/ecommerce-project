Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  resources :products, only: %i[index show]

  root to: "products#index"
end
