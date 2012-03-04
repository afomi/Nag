Nag::Application.routes.draw do

  get "checkins/data"

  match "status/:id", :controller => "application", :action => "monitor_status", :id => "id"

  resources :checkins

  root :to => "checkins#new"
end
