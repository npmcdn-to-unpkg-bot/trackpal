Rails.application.routes.draw do


  resources :groups, :only => [:show]
  resources :users, :except => [:edit]
  resources :friendships

  root :to => "pages#index"

  # AJAX-only endpoints
  post '/submit_position' => 'groups#submit_position'
  get '/submit_position' => 'groups#submit_position'
  get '/get_group_details' => 'groups#get_group_details'
  get '/get_group_coordinates' => 'groups#get_group_coordinates'

  post '/send_text' => 'send_text#send_text_message'

  get '/users/:id/edit' => 'users#edit', :as => 'users_edit'
  get '/users/:id/friends' => 'users#friends', :as => 'users_friends'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/logout' => 'session#destroy'

end
