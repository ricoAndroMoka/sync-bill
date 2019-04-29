Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#index'
  post '/target', to: 'static_pages#target'
  post '/return_error', to: 'static_pages#return_error'

  get '/advance_ordering', to: 'static_pages#advance_ordering'
  post '/target_advance_ordering', to: 'static_pages#target_advance_ordering'

end
