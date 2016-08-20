Rails.application.routes.draw do


  resources :groups, :only => [:show]
  resources :users, :only => [:index, :show, :edit, :new]
  resources :friendships

  root :to => "pages#index"

  # AJAX-only endpoints
  post '/submit_position' => 'groups#submit_position'
  get '/submit_position' => 'groups#submit_position'
  get '/get_group_details' => 'groups#get_group_details'
  get '/get_group_coordinates' => 'groups#get_group_coordinates'


  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/logout' => 'session#destroy'

end
