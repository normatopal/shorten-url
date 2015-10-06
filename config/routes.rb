Rails.application.routes.draw do

  devise_for :users
  resources :links

  get 'shorten/:short_url', to: 'links#shorten', as: 'shorten'

  #root 'home#index'
  root 'links#new'

  get '/:short_url' => 'links#redirect_to_url', as: 'redirect_to_long'
end
