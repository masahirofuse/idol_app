Rails.application.routes.draw do


  get '/topics' => "topics#index"
  get "/topics/new" => "topics#new"
  post "/topics/create" =>"topics#create"
  get "/topics/search" => "topics#search"
  get "/topics/:id" => "topics#show"
  get "/topics/:id/edit" => "topics#edit"
  post "/topics/:id/update" => "topics#update"
  post "/topics/:id/destroy" => "topics#destroy"
  get "/topics/:id/confirm" => "topics#confirm"
  
  get '/' => "home#top"
  
 
  get "/users/index" => "users#index"
  
  get "/signup"=> "users#signup"
  get "/login" => "users#login_form"
  post "/login" => "users#login"
  post "/logout" => "users#logout"
  post "/users/create" => "users#create"
  get "/users/:id" => "users#show"
  get "/users/:id/edit" => "users#edit"
  post "/users/:id/update" => "users#update"
  
  post "/posts/create" => "posts#create"
  get "/posts/:id/edit" => "posts#edit"
  post "/posts/:id/update" => "posts#update"
  post "/posts/:id/destroy" => "posts#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
