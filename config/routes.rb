Nag::Application.routes.draw do

  resources :checkins

  root :to => "checkins#new"
end
