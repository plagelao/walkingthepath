Walkingthepath::Application.routes.draw do
  root :to => "events#index"
  resources :events
  match '/auth/twitter/callback' => 'users#authentication'
end
