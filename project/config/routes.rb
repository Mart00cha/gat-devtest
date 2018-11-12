Rails.application.routes.draw do
  root controller: :pages, action: :root

  get '/locations/:country_code', to: 'locations#index'
end
