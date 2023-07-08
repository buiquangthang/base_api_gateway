Rails.application.routes.draw do
  post 'sign_in', to: 'sessions#sign_in'

  resources :routes
  resources :services

  DynamicRouter.load
end
