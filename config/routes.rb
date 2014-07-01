Toomanychips::Application.routes.draw do

  get 'auth/:provider/callback', to: 'session#oauth_create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'session#destroy', via: :destroy
  root to: 'pages#index'
  resources :users, :only => [:show, :create, :new, :edit, :guest_create, :update] 
  post 'create_guest' => 'users#create_guest'
  resources :assigned_items, :except => [:index]
  delete 'remove/:id', to: 'assigned_items#destroy', as: 'remove'
  get 'add_image/:id', to: "events#add_image", as: 'add_image'

  get 'your_profile', to: 'users#your_profile', as: 'your_profile'
  resources :session, :only => [:create]
  get 'login'  => 'users#simple_login', :as => 'login'
  post 'login' => 'session#create'
  get 'guest/:url' => 'users#guest', as: 'guest'

  resources :events
  get 'event/:url' => 'events#invitation', :as => 'invitation'
  get '/contributions/:id' => 'events#contributions', :as => 'contributions'

  resources :items
  
  
  # resources :guests, :only => [:show, :edit, :new, :create]
  # get '/rsvp/:url' => 'guests#show', :as => 'rsvp'

  mount Sidekiq::Web, at: "/sidekiq"

end
