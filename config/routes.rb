Rails.application.routes.draw do

  get '/posts', to: 'posts#index'

  get '/posts/:id', to: 'posts#show'

  post '/posts', to: 'posts#create'

  put '/posts/:id', to: 'posts#update'

  delete '/posts/:id', to: 'posts#delete'

  post '/postsseed', to: 'posts#create_many'




  get '/accounts', to: 'accounts#index'

  post '/accounts/login', to: 'accounts#show'

  post '/accounts', to: 'accounts#create'

  put '/accounts/:id', to: 'accounts#update'

  delete '/accounts/:id', to: 'accounts#delete'


  get '/subreddits', to: 'subreddits#index'

  get '/subreddits/:id', to: 'subreddits#show'

  post '/subreddits', to: 'subreddits#create'

  delete '/subreddits/:id', to: 'subreddits#delete'




end
