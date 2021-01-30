Rails.application.routes.draw do

  get '/posts', to: 'posts#index'

  get '/posts/:id', to: 'posts#show'

  post '/posts', to: 'posts#create'

  put '/posts/:id', to: 'posts#update'

  delete '/posts/:id', to: 'posts#delete'

  post '/postsseed', to: 'posts#create_many'




  get '/accounts', to: 'accounts#index'

  get '/accounts/:id', to: 'accounts#show'

  post '/accounts', to: 'accounts#create'

  put '/accounts/:id', to: 'accounts#update'

  delete '/accounts/:id', to: 'accounts#delete'




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
