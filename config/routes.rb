RailsWithBs::Application.routes.draw do
  resources :events

  resources :ride_drivers

  resources :ride_passengers

  resources :locations

  resources :rides

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end