Toomanychips::Application.routes.draw do

  get 'auth/:provider/callback', to: 'session#oauth_create'
  get 'auth/failure', to: redirect('/')

  root to: 'pages#index'
  resources :users, :only => [:show, :create, :new, :edit, :guest_create] 
  resources :assigned_items, :except => [:index]
  delete 'remove/:id', to: 'assigned_items#destroy', as: 'remove'
  get 'add_image/:id', to: "events#add_image", as: 'add_image'

  get 'your_profile', to: 'users#your_profile', as: 'your_profile'
  resources :session, :only => [:destroy, :create]
  post 'login' => 'session#create', :as => 'login'
  delete 'signout', to: 'session#destroy', as: 'signout'
  get 'guest/:url' => 'users#guest', as: 'guest'

  resources :events
  get '/:url' => 'events#invitation', :as => 'invitation'
  get '/contributions/:id' => 'events#contributions', :as => 'contributions'

  resources :items
  
  
  # resources :guests, :only => [:show, :edit, :new, :create]
  # get '/rsvp/:url' => 'guests#show', :as => 'rsvp'

  mount Sidekiq::Web, at: "/sidekiq"

end
