Rails.application.routes.draw do
  root 'deals#index'
  resources :rsvps
  post '/messages/request_confirmation', to: 'messages#request_confirmation'
  post '/messages/reply', to: 'messages#reply'
end
