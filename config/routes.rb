Rails.application.routes.draw do

  resources :links, :only => [:new, :create]

  get 'shorten/:short_url', to: 'links#shorten', as: 'shorten'

  #root 'home#index'
  root 'links#new'

  get '/:short_url' => 'links#redirect_to_url', as: 'redirect_to_long'
end
