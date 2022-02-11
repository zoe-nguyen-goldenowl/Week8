Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "sig_in" => "users#login"
  
  get "successful" => "users#successful"
  post "user/verify" => "users#verify", as: :verify

  resources :users
  get "sig_in" => "users#sig_in"
  
end
