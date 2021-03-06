Rails.application.routes.draw do

  get '/posts', to: 'posts#index'

  get '/posts/:id', to: 'posts#show'

  post '/posts', to: 'posts#create'

  put '/posts/:id', to: 'posts#update'

  delete '/posts/:id', to: 'posts#delete'

  post '/postsseed', to: 'posts#create_many'

  put '/upvote', to: 'posts#upvote'

  put '/downvote', to: 'posts#downvote'




  get '/accounts', to: 'accounts#index'

  post '/accounts/login', to: 'accounts#show'

  post '/accounts', to: 'accounts#create'

  put '/accounts/:id', to: 'accounts#update'

  put '/addsub', to:'accounts#addsub'

  put '/leavesub', to:'accounts#leavesub'

  delete '/accounts/:id', to: 'accounts#delete'

  put '/react', to: 'accounts#react'



  get '/subreddits', to: 'subreddits#index'

  get '/subreddits/:id', to: 'subreddits#show'

  post '/subreddits', to: 'subreddits#create'

  put '/followsub', to: 'subreddits#followsub'

  put '/unfollowsub', to: 'subreddits#unfollowsub'

  delete '/subreddits/:id', to: 'subreddits#delete'

  put '/subreddits', to: 'subreddits#addpost'



end
