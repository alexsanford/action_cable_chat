Rails.application.routes.draw do
  root 'home#index'

  get '/disconnect' => 'home#disconnect'

  resources :messages
end
