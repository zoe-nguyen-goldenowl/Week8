Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "new_password" => "users#new_password"
  put "change_pass" => "users#change_pass"

  post "sign_in" => "sessions#login"
  post "forgot_password" => "users#forgot_password"
  post 'auth_user' => 'authentication#authenticate_user'

  get "forgot_password" => "users#forgot_password"
  get "successful/:id" => "users#successful", as: "successful"
  
  get "user/verify" => "users#verify", as: :verify
  get "sign_in" => "users#sign_in"
  get "sign_in_form" => "users#sign_in_form"
  get "index" => "users#index", as: "sign_up"

  resources :users
  root to:"users#root_page", as: "root"
  
end
