Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "hello_world", to: "hello#index"

  root "main#index"
  resources :posts, only: [:new, :create, :show]
end
