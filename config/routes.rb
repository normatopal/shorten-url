Rails.application.routes.draw do


  #get '/shorten' => 'links#generate', as: :generate
  resources :links, :only => [:new, :create]

  get 'shorten/:short_url', to: 'links#shorten', as: 'shorten'

  #root 'home#index'
  root 'links#new'

  get '/:short_url' => 'links#redirect_to_url'
end
