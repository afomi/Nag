Nag::Application.routes.draw do

  resources :thoughts
  resources :documents
  resources :habits

  get "tags", :to => "checkins#tags"
  match "help", :to => "status#help"
  get "just_login", :to => "checkins#just_login"
  get "logout", :to => "checkins#logout"
  get "checkins/data"

  match "status/:id", :controller => "status", :action => "edit", :id => "id"
  match "status/:app/:key/:value/", :controller => "status", :action => "update", :app => "app", :key => "id", :value => "value"

  resources :checkins
  resources :touchpoints

  root :to => "checkins#new"
end
