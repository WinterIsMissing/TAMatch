Rails.application.routes.draw do
  get 'instructors/index'
  post 'instructors/add'
  get 'instructors/remove'
  
  post 'course_overview/index'

  get 'prof_ranking/index'

  get 'ta_application/index'

  get '/auth', to: 'session#auth'


  resources :taapps
  resources :session, only: [:new, :create]
  root 'static#home'
  get '/auth/:provider/callback', to: 'session#create_oauth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  get '/register', to: 'users#register'
  post '/login', to: 'session#send_link'
  #Dashboard
  resources :dashboard, only: [:create]
  get '/dashboard', to: 'dashboard#index'
  
end
