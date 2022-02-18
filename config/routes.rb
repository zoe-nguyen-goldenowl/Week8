Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "new_password" => "users#new_password"
  get "change_pass" => "users#change_pass"

  post "sign_in" => "sessions#login"
  post 'auth_user' => 'authentication#authenticate_user'
  post "new" => "users#create"

  get "forgot_password" => "users#forgot_password"
  get "successful/:id" => "users#log_in_successful_view", as: "successful"
  
  get "user/verify" => "users#verify", as: :verify
  get "sign_in" => "users#sign_in"
  get "sign_in_form" => "users#sign_in_form"
  get "new" => "users#new", as: "sign_up"

  get "edit" => "users#edit_user"
  resources :users
  root to:"users#root_page", as: "root"
  
end
