Rails.application.routes.draw do
  get 'matchmaker/index'
  post 'matchmaker/index'
  
  get 'instructors/index'
  post 'instructors/add'
  get 'instructors/remove'
  
  post 'course_overview/index'

  get "prof_ranking/show" => 'prof_ranking#show', :as => :prof_ranking_show
  
  get 'prof_ranking/index'
  post 'prof_ranking/update'
  post 'prof_ranking/search'
  
  get 'ta_application/index'

  get '/auth', to: 'session#auth'
 # resources :prof_ranking
  resources :applicants
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
  
  get '/view_applications', to: 'applicants#submitted'
  
  
end
