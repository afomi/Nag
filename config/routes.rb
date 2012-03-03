Nag::Application.routes.draw do

  get "checkins/data"

  resources :checkins

  root :to => "checkins#new"
end
