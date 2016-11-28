Rails.application.routes.draw do
	root 'static_pages#home'
	get    '/login',   to: 'sessions#new'
  	post   '/login',   to: 'sessions#create'
  	delete '/logout',  to: 'sessions#destroy'
	get  '/signup',    to: 'users#new'
	post '/signup',	   to: 'users#create'
	get '/index', 	   to: 'requests#index'
	resources :reports
	resources :users
	resources :account_activations, 	only: [:edit]
	resources :messages,		  		only: [:create, :destroy]
	resources :contracts
	resources :requests,         		only: [:create, :destroy]
	resources :password_resets,     	only: [:new, :create, :edit, :update]
	resources :origins,					only: [:new, :create, :destroy]
	resources :product_types,			only: [:new, :create, :destroy]
end