Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "sign_in" => "users#login"
  post "forgot_password" => "users#forgot_password"
  post "change_pass" => "users#change_pass"

  get "forgot_password" => "users#forgot_password"
  get "successful" => "users#successful"
  get "change_pass" => "users#change_pass"
  get "user/verify" => "users#verify", as: :verify

  resources :users
  get "sign_in" => "users#sign_in"
  
end
