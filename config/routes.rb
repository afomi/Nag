Nag::Application.routes.draw do

  resources :touchpoints

  get "checkins/data"

  match "status/:id", :controller => "status", :action => "edit", :id => "id"

  resources :checkins

  root :to => "checkins#new"
end
