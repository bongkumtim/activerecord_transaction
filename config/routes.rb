Rails.application.routes.draw do
  devise_for :users

root 'accounts#index'

resources :accounts

get '/p2p' => "accounts#p2p"
get '/transfer' => "accounts#transfer"
get '/exchange' => "accounts#exchange"
get "/currency" => "accounts#currency"

end
