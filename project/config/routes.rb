Rails.application.routes.draw do
  root controller: :pages, action: :root

  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'

  get '/locations/:country_code', to: 'locations#index'
  get '/target_groups/:country_code', to: 'target_groups#index'
  get '/private/locations/:country_code', to: 'private/locations#index'
  get '/private/target_groups/:country_code', to: 'private/target_groups#index'
  post '/private/evaluate_target', to: 'private/target_groups#evaluate'
end
