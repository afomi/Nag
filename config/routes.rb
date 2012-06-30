Nag::Application.routes.draw do

  resources :habits

  match "help", :to => "status#help"
  get "checkins/data"

  match "status/:id", :controller => "status", :action => "edit", :id => "id"
  match "status/:app/:key/:value/", :controller => "status", :action => "update", :app => "app", :key => "id", :value => "value"

  resources :checkins
  resources :touchpoints

  root :to => "checkins#new"
end
