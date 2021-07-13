Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  #route to go to my_portfolio page
  #it will be associated with users and the user controller will have a my_portfolio action
  get 'my_portfolio', to: 'users#my_portfolio'
  #to submit the stock form route
  get 'search_stock', to: 'stocks#search'

  resources :user_stocks, only: [:create, :destroy]
end
