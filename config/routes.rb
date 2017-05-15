Rails.application.routes.draw do
  root 'deals#index'
  resources :rsvps
end
