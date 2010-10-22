Champax::Application.routes.draw do

  namespace :admin do
    root :to => 'coupons#index'
    resources :businesses
    resources :categories 
    resources :coupons
    resources :sessions, :only => [:new, :create, :destroy]
    resources :admin_user, :only => [:edit, :update]
    
    match '/login', :to => 'sessions#new'
    match '/logout', :to => 'sessions#destroy'
  end
  
  match "/New-Coupons" => 'views#by_new', :as => :coupons_by_new 
  match "/Hot-Coupons" => 'views#by_hot', :as => :coupons_by_hot 
  match "/Online-Only-Coupons" => 'views#by_online_only', :as => :coupons_by_online_only
  match "/:name/c/" => 'views#by_category'
  match "/:name/t/" => 'views#by_town'
  match "/:name/d/" => 'views#by_distance'
  match "/:business_name/:short_description/:id/" => 'views#coupon', :constraints => { :short_description => /.*/ }
  match "/print/:id" => 'views#print_coupon'
  
  root :to => 'pages#home'

end
