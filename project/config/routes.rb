Rails.application.routes.draw do
  root controller: :pages, action: :root

  get '/locations/:country_code', to: 'locations#index'
  get '/target_groups/:country_code', to: 'target_groups#index'
  post 'evaluate_target', to: 'target_groups#evaluate'
end
