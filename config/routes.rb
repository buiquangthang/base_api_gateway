Rails.application.routes.draw do
  post 'sign_in', to: 'sessions#sign_in'

  resources :routes
  resources :services

  post "services/:id/toggle", to: "services#toggle"

  DynamicRouter.load
end
