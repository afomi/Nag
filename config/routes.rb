Nag::Application.routes.draw do

  resources :thoughts
  resources :documents
  resources :habits

  get "help", to: "status#help"

  get "tags", to: "checkins#tags"
  get "just_login", to: "checkins#just_login"
  get "logout", to: "checkins#logout"
  get "checkins/data"

  get "status/:id", :controller => "status", :action => "edit", :id => "id"
  get "status/:app/:key/:value/", :controller => "status", :action => "update", :app => "app", :key => "id", :value => "value"

  resources :checkins
  resources :touchpoints

  root to: "checkins#new"
end
