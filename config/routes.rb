Nag::Application.routes.draw do

  match "help", :to => "status#help"
  get "checkins/data"

  match "status/:id", :controller => "status", :action => "edit", :id => "id"

  resources :checkins
  resources :touchpoints

  root :to => "checkins#new"
end
